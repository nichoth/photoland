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
      dataType = 'enum',
      values = {
        {
          value = nil,
          title = '',
        },
        {
          value = 'Steve Davis',
          title = 'Steve Davis',
        },
        {
          value = 'Amjad Faur',
          title = 'Amjad Faur',
        },

      },
    },


  }
}