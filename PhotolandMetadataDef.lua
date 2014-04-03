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
        {
          value = 'Bob Haft',
          title = 'Bob Haft',
        },
        {
          value = 'Hugh Lentz',
          title = 'Hugh Lentz',
        },
        {
          value = 'Julia Zay',
          title = 'Julia Zay',
        },
        {
          value = 'Other',
          title = 'Other',
        },

      },
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
          value = 'BW silver print'
          title = 'BW silver print'
        },

        {
          value = 'Color print (darkroom)'
          title = 'Color print (darkroom)'
        },

        {
          value = 'Digital inkjet'
          title = 'Digital inkjet'
        },

        {
          value = 'Alternative process'
          title = 'Alternative process'
        },

      },
    },


  }
}