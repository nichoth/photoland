--[[----------------------------------------------------------------------------

Validates metadata for photos in the current export.

Adds section to export dialog for copyright info.

______________________________________________________________________________]]

local LrView = import 'LrView'
local LrExportSession = import 'LrExportSession'
local catalog = import 'LrApplication'.activeCatalog()
local LrTasks = import 'LrTasks'

PhotolandMain = {}

--[[----------------------------------------------------------------------------
-- Validate metadata and bind data to UI.
------------------------------------------------------------------------------]]
function PhotolandMain.startDialog(propertyTable)

  -- validate metadata
  LrTasks.startAsyncTask( function (propertyTable)
    
      local photos = catalog:getTargetPhotos()
    -- dump('photos', photos)
    -- dump('meta', photos[1]:getFormattedMetadata('title'))

  end)

  dump('table', propertyTable.LR_cantExportBecause)

  -- create property for copyright disclosure
  propertyTable.bc = 'You have to agree to the copyright stuff.'
  propertyTable.can_export = false
  propertyTable.LR_cantExportBecause = propertyTable.bc

  propertyTable:addObserver( 'can_export', updateStatus )

  -- propertyTable.LR_cantExportBecause = LrView.bind(propertyTable.checkbox_state)
  
end


--[[----------------------------------------------------------------------------
-- Updates whether or not we are allowed to export.

------------------------------------------------------------------------------]]
function updateStatus( propertyTable )

  if propertyTable.can_export == true then
    propertyTable.LR_cantExportBecause = nil
  else
    propertyTable.LR_cantExportBecause = propertyTable.bc
  end
end




--[[----------------------------------------------------------------------------
---Bottom section. Consent for copyright stuff.
--- @todo bind checkbox to some data.
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
            value = LrView.bind('can_export'),
            checked_value = true,
            unchecked_value = false,
          },

          f:static_text {
            fill_horizontal = 1,
            title = LrView.bind('can_export'), -- bound to same key as checkbox value
          },
        }
      }
    }
  }
  return result

end
