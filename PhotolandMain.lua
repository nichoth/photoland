--[[----------------------------------------------------------------------------

Adds custom section to export dialog.

______________________________________________________________________________]]

local LrView = import 'LrView'
local LrExportSession = import 'LrExportSession'
local catalog = import 'LrApplication'.activeCatalog()
local LrTasks = import 'LrTasks'

PhotolandMain = {}

function PhotolandMain.startDialog()

  local photos = catalog:getTargetPhotos()
  -- dump('photos', photos)

  dump('meta', photos[1]:getFormattedMetadata())
  
end

function PhotolandMain.startTask()

  LrTasks.startAsyncTask(PhotolandMain.startDialog)

end

function PhotolandMain.sectionsForBottomOfDialog(_, propertyTable)

end
