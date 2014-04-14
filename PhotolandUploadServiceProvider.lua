local Require = require 'Require'.path ("../debugscript.lrdevplugin")
local Debug = require 'Debug'.init ()
require 'strict'

require "PhotolandMain"
require "HttpUploadTask"
require 'Util'

return {
  hideSections = {
    'fileSettings',
    'watermarking',
    'metadata',
    'outputSharpening',
    'video',
    'exportLocation',
  },

  allowFileFormats = { 'JPEG' },

  allowColorSpaces = { 'sRGB' },

  hidePrintResolution = true,

  exportPresetFields = {
    -- { key = "httpPreset", default = nil }
    { key = 'LR_size_resizeType', default = 'longEdge' },
    { key = 'LR_size_units', default = 'pixels' },
    { key = 'LR_size_maxHeight', default = 2000 },
    { key = 'LR_size_doNotEnlarge', default = true},
  },

  startDialog = PhotolandMain.startDialog,

  sectionsForBottomOfDialog = PhotolandMain.sectionsForBottomOfDialog,

  processRenderedPhotos = Debug.showErrors(HttpUploadTask.processRenderedPhotos),

}