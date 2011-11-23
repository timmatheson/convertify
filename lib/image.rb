module Convertify
  
  module Image
    
    def self.process( options = {} )
      log = Logger.new('convertify.log')
      log.debug( options )
      file = temp_file( options )
      
      
      return file if file.is_a?(Hash)
      
      case options[:conversion]
      when 'rotate'
        return { :file => rotate( file, options[:degrees] )}
      else
        raise RequestException, "Unsupported conversion value. :#{options[:conversion]}"
      end
    end
    
    private
    
    def self.temp_file( options = {})
      validates_image( options )
      file = Tempfile.new('file')
      file.write( options[:file][:tempfile].read )
      file
    end
    
    def self.rotate( image, degrees = 90)
      im = Magick::ImageList.new( image.path )
      im = im.rotate( degrees.to_f )
      im.write( "rotated-" + File.basename(image.path) )
      im.filename
    end
    
    def self.validates_image( options = {} )
      if( !options[:file] || !options[:file].has_key?(:tempfile) )
        raise RequestException, 'Missing the file data to convert.'
      end
    end
    
  end
end