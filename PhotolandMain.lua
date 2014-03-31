--[[----------------------------------------------------------------------------

Adds custom section to export dialog.

______________________________________________________________________________]]

local LrView = import 'LrView'
local LrExportSession = import 'LrExportSession'
local catalog = import 'LrApplication'.activeCatalog()

PhotolandMain = {}

function PhotolandMain.startDialog(propertyTable)

  local photos = catalog:getTargetPhotos()
  dump('photos', photos)
  
end

function PhotolandMain.sectionsForBottomOfDialog(_, propertyTable)

end
