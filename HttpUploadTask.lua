--[[----------------------------------------------------------------------------

Upload photos via HTTP Post request.

------------------------------------------------------------------------------]]
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
local content = {
  {
    name = 'item_meta[93]',
    value = 'test value',
  },
  {
    name = 'item_meta[96]',
    value = 'value 2'
  }
}

-------------------------------------------------------------------------------

HttpUploadTask = {}

-- for debugging
function HttpUploadTask.outputToLog( message )
  logger:trace( message )
end

function HttpUploadTask.processRenderedPhotos( functionContext, exportContext )
    
  -- Make a local reference to the export parameters.
  local exportSession = exportContext.exportSession
  local exportParams = exportContext.propertyTable
  local httpPreset = exportParams.httpPreset

  -- local nPhotos = exportSession:countRenditions()

  local response, headers = LrHttp.postMultipart(addr, content)

  -- debug(response)
  for photo in exportSession:photosToExport() do
    dump('photo', photo)
  end

end