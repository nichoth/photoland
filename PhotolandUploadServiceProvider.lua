local Require = require 'Require'.path ("../debugscript.lrdevplugin")
local Debug = require 'Debug'.init ()
require 'strict'

require "PhotolandMain"
require "HttpUploadTask"
require 'Util'

return {
  showSections = {
    'fileNaming',
    'fileSettings',
    'outputSharpening',
    'watermarking',
  },

  allowFileFormats = { 'JPEG' },

  allowColorSpaces = { 'sRGB' },

  hidePrintResolution = true,

  -- exportPresetFields = {
  --   { key = "httpPreset", default = nil }
  -- },

  startDialog = PhotolandMain.startDialog,

  sectionsForBottomOfDialog = PhotolandMain.sectionsForBottomOfDialog,

  processRenderedPhotos = Debug.showErrors(HttpUploadTask.processRenderedPhotos),

}