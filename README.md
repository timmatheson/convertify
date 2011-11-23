Convertify
---

  Convertify is a simple API service which does basic "offsite" and "cloudbased" image conversion.
  This allows for applications to perform image conversion routines without adding dependencies to their
  applications / environments such as Ghostscript and ImageMagick which is used by Convertify.
  
  
Api
---
  
  The api is a very simple one. This is a rack app and currently only features one conversion route.
  
  
  * Convert an Image
  
  
    # POST /api/images/convert.json
  
    # - conversion            The conversion method you want to perform on the posted file.
    # - file                  This should be a multipart file upload
    # - degrees               This is angle degrees for rotations
  
    # Request
    {
      :file => <MultiPart/>,
      :conversion => 'rotate',
      :degrees => 20
    }
  
    # Response
    {
      :file => 'http://images.convertify.com/120192812.jpg'
    }
  