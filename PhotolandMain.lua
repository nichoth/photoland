--[[----------------------------------------------------------------------------

Validates metadata for photos in the current export.

Adds section to export dialog for copyright info.

______________________________________________________________________________]]

local LrView = import 'LrView'
local LrExportSession = import 'LrExportSession'
local catalog = import 'LrApplication'.activeCatalog()
local LrTasks = import 'LrTasks'

-- debug stuff
local LrLogger = import 'LrLogger'
local logger = LrLogger('mainLogger')
logger:enable("logfile")

PhotolandMain = {}

--[[----------------------------------------------------------------------------
-- Metadata that needs to be set.
------------------------------------------------------------------------------]]
PhotolandMain.requiredMetadata = {
  adobe = 
  {
    'creator',
    'creatorEmail',
    'title',
  },
  photoland = 
  {
    'course',
    'faculty',
    'medium',
    'year',
  },
  
}

--[[----------------------------------------------------------------------------
-- Validate metadata and bind data to UI.
------------------------------------------------------------------------------]]
function PhotolandMain.startDialog(propertyTable)

  -- set up property table for copyright stuff
  propertyTable.agree = false
  propertyTable.validMeta = true

  -- add observer for copyright
  propertyTable:addObserver( 'agree', PhotolandMain.updateStatus )

  -- validate metadata
  LrTasks.startAsyncTask( function ()
    
    local photos = catalog:getTargetPhotos()

    local customMeta = catalog:batchGetPropertyForPlugin(photos, 'com.adobe.lightroom.photoland', PhotolandMain.requiredMetadata.photoland)
    local adobeMeta = catalog:batchGetFormattedMetadata(photos, PhotolandMain.requiredMetadata.adobe)

    -- validate adobe metadata
    for _, photo in pairs(adobeMeta) do
      for _, metaValue in pairs(photo) do
        if metaValue == '' or metaValue == nil then
          dump('inval', _)
          propertyTable.validMeta = false
        end
      end
    end

    -- validate photoland metadata
    for _, photo in pairs(customMeta) do
      for _, requiredMeta in pairs(PhotolandMain.requiredMetadata.photoland) do
        if photo[requiredMeta] == nil or photo[requiredMeta] == '' then
          dump('inval2', requiredMeta)
          propertyTable.validMeta = false
        end
      end
    end

  end)

  PhotolandMain.updateStatus(propertyTable)
  
end




--[[----------------------------------------------------------------------------
-- Updates whether or not we are allowed to export.

------------------------------------------------------------------------------]]
function PhotolandMain.updateStatus( propertyTable )

  local message = nil

  if propertyTable.validMeta == false then
    propertyTable.LR_cantExportBecause = "Not all required metadata is set."
  elseif not propertyTable.agree then
    propertyTable.LR_cantExportBecause = "You have to agree to the copyright stuff."
  else
    propertyTable.LR_cantExportBecause = nil
  end
end




--[[----------------------------------------------------------------------------
-- Bottom dialog section. Consent for copyright stuff.
------------------------------------------------------------------------------]]
function PhotolandMain.sectionsForBottomOfDialog(_, propertyTable)

  local f = LrView.osFactory()

  local confirm = [[    By submitting work and information, you agree to allow The Evergreen State College
    to publish such information, attributed to you as
    an enrolled student. The creator (you) retain the copyright.]]

  local result = {

    {
      title = 'Photoland',

      f:column {
        f:static_text {
          title = confirm,
        },

        f:row {
          bind_to_object = propertyTable,
          f:checkbox {
            title = 'Agree',
            value = LrView.bind('agree'),
            checked_value = true,
            unchecked_value = false,
          },

          f:static_text {
            fill_horizontal = 1,
            title = LrView.bind('agree'), -- bound to same key as checkbox value
          },
        }
      }
    }
  }
  return result

end
