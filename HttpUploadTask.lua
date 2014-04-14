--[[----------------------------------------------------------------------------

Upload photos via HTTP Post request.

------------------------------------------------------------------------------]]
require 'PhotolandMain'

local LrPathUtils = import 'LrPathUtils'
local LrHttp = import 'LrHttp'
local LrFileUtils = import 'LrFileUtils'
local LrErrors = import 'LrErrors'
local LrDialogs = import 'LrDialogs'
local LrMD5 = import "LrMD5"

-- debug stuff
local LrLogger = import 'LrLogger'
local logger = LrLogger('httpLogger')
logger:enable("logfile")

local debug, info, warn, err = logger:quick('debug', 'info', 'warn', 'err')

--test stuff
local addr = 'http://localhost:8888/photo/index.php'
-- local content = {
--   {
--     name = 'item_meta[93]',
--     value = 'test value',
--   },
--   {
--     name = 'item_meta[96]',
--     value = 'value 2'
--   }
-- }

-------------------------------------------------------------------------------

HttpUploadTask = {}

function HttpUploadTask.processRenderedPhotos( functionContext, exportContext )
    
  -- Make a local reference to the export parameters.
  local exportSession = exportContext.exportSession
  local exportParams = exportContext.propertyTable
  local httpPreset = exportParams.httpPreset
  local catalog = exportSession.catalog

  -- Make progress dialog.
  local nPhotos = exportSession:countRenditions()

  local progressScope = exportContext:configureProgress {
          title = nPhotos > 1
                and LOC( "Uploading ^1 photos to Photoland", nPhotos )
                or LOC "Uploading one photo to Photoland",
        }

  -- start rendering
  for i, rendition in exportContext:renditions { stopIfCancelled = true } do

    progressScope:setPortionComplete( ( i - 1 ) / nPhotos )

    local photo = rendition.photo

    -- set up metadata
    local metadata = {}

    -- custom metadata
    for _, value in pairs(PhotolandMain.requiredMetadata.photoland) do
      metadata[value] = photo:getPropertyForPlugin('com.adobe.lightroom.photoland', value)
    end

    -- adobe metadata
    for _, value in pairs(PhotolandMain.requiredMetadata.adobe) do
      metadata[value] = photo:getFormattedMetadata(value)
    end

    -- get remaining optional metadata
    metadata['description'] = photo:getPropertyForPlugin('com.adobe.lightroom.photoland', 'description')
      or nil
    metadata['creatorUrl'] = photo:getFormattedMetadata('creatorUrl')


    -- render photo
    local success, pathOrMessage = rendition:waitForRender()

    -- Update progress scope again once we've got rendered photo.
    progressScope:setPortionComplete( ( i - 0.5 ) / nPhotos )

    if progressScope:isCanceled() then break end

    -- Set up data for post request
    local mimeChunks = {}
    mimeChunks = {
      {
        name = 'file93',
        fileName = LrPathUtils.leafName( pathOrMessage ),
        filePath = pathOrMessage,
        -- contentType = 'image/jpeg',
      },
      {
        name = 'item_meta[102][]',
        value = 'agree',
      },
    }

    -- map form fields to our metadata
    local fieldMap = {
      ['item_meta[83]'] = 'creator',
      ['item_meta[85]'] = 'creatorEmail',
      ['item_meta[86]'] = 'creatorUrl',
      ['item_meta[96]'] = 'title',
      ['item_meta[98]'] = 'description',
      ['item_meta[94]'] = 'course',
      ['item_meta[99]'] = 'course',
      ['item_meta[108][]'] = 'faculty',
      ['item_meta[109]'] = 'faculty',
      ['item_meta[100]'] = 'year',
      ['item_meta[95][]'] = 'medium',
    }

    -- create mime chunks for each form field
    for k, v in pairs(fieldMap) do
      if metadata[v] then
        mimeChunks[#mimeChunks + 1] = { name = k, value = metadata[v] }
      end
    end

    -- send post request
    local response, headers = LrHttp.postMultipart(addr, mimeChunks)

    dump('response', response)


  end -- end render loop

end