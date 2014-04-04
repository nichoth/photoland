--[[----------------------------------------------------------------------------

Validates metadata for photos in the current export.

Adds section for copyright info.

______________________________________________________________________________]]

local LrView = import 'LrView'
local LrExportSession = import 'LrExportSession'
local catalog = import 'LrApplication'.activeCatalog()
local LrTasks = import 'LrTasks'

PhotolandMain = {}

--[[----------------------------------------------------------------------------
---Validates metadata.
------------------------------------------------------------------------------]]
function PhotolandMain.startDialog(propertyTable)

  LrTasks.startAsyncTask( function (propertyTable)
    
      local photos = catalog:getTargetPhotos()
    -- dump('photos', photos)
    dump('meta', photos[1]:getFormattedMetadata('title'))

  end)
  
end


--[[----------------------------------------------------------------------------
---Bottom section. Obtains consent for copyright stuff.
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
          f:checkbox {
            title = 'Agree',
            value = false,
          },
          f:checkbox {
            title = 'Don\'t Agree',
            value = true,
          },
        }
      }
    }

  }

  return result

end
