return {

  LrSdkVersion = 3.0,
  LrToolkitIdentifier = 'com.adobe.lightroom.photoland',
  LrPluginName = "Photoland Website",

  LrExportServiceProvider = {
    title = "Photoland Website",
    file = 'PhotolandUploadServiceProvider.lua',
    builtInPresetsDir = 'settings',
  },

  LrExportMenuItems = {
    {title = "Debug Script", file = "DebugScript.lua"}
  },

  LrMetadataProvider = 'PhotolandMetadataDef.lua',

  LrMetadataTagsetFactory = 'PhotolandTagset.lua',
}