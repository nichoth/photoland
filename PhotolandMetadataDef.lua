--[[----------------------------------------------------------------------------

Defines sutom metadata corresponding to the form fields on the Photoland 
website.

------------------------------------------------------------------------------]]

return {

  schemaVersion = 1,
  
  metadataFieldsForPhotos = {

    {
      id = 'course',
      title = 'Course or Program',
      dataType = 'string',
    },
    {
      id = 'description',
      title = 'Description',
      dataType = 'string',
    },
    {
      id = 'faculty',
      title = 'Primary Faculty',
      dataType = 'string',
    },

    {
      id = 'year',
      title = 'Academic Year',
      dataType = 'string',
    },

    {
      id = 'medium',
      title = 'Medium',
      dataType = 'enum',
      values = {
        {
          value = 'BW silver print',
          title = 'BW silver print',
        },

        {
          value = 'Color print (darkroom)',
          title = 'Color print (darkroom)',
        },

        {
          value = 'Digital inkjet',
          title = 'Digital inkjet',
        },

        {
          value = 'Alternative process',
          title = 'Alternative process',
        },

      },
    },


  }
}