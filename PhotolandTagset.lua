--[[----------------------------------------------------------------------------

Tagset definition for Photoland website.

------------------------------------------------------------------------------]]

return {
  
  id = 'photolandTagset',
  title = 'Photoland',

  items = {

    -- required
    {'com.adobe.label', label = 'Required'},
    'com.adobe.creator',
    'com.adobe.creatorWorkEmail',
    'com.adobe.title',
    'com.adobe.lightroom.photoland.course',
    'com.adobe.lightroom.photoland.faculty',
    'com.adobe.lightroom.photoland.medium',
    'com.adobe.lightroom.photoland.year',

    -- optional
    'com.adobe.separator',
    {'com.adobe.label', label = 'Optional'},
    'com.adobe.lightroom.photoland.description',
    'com.adobe.creatorWorkWebsite',

  }
}