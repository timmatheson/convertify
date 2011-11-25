module Convertify
  
  module Image
    
    def self.process( options = {} )
      log = Logger.new('log/convertify.log')
      log.debug( options )
      file = temp_file( options )
      
      
      return file if file.is_a?(Hash)
      
      case options[:conversion]
      when 'rotate'
        return { :url => rotate( file, options )}
      when 'crop'
        return { :url => crop( file, options )}
      when 'resize'
        return { :url => crop( file, options )}
      else
        raise RequestException, "Unsupported conversion value. :#{options[:conversion]}"
      end
    end
    
    private
    
    def self.temp_file( options = {})
      validates_image( options )
      file = Tempfile.new(options[:filename])
      file.write( options[:file][:tempfile].read )
      file
    end
    
    def self.rotate( image, options = {})
      im = Magick::ImageList.new( image.path )
      im.rotate( options[:degrees].to_f ).write( file_write_path("rotated-#{options[:degrees]}-#{options[:file][:filename]}") )
      url(im.filename)
    end
    
    # Handles both resize and crop
    def self.crop( image, options = {})
      write_path = file_write_path( "#{options[:conversion]}-#{options[:width]}-#{options[:height]}-#{options[:file][:filename]}" )
      im = Magick::Image.read(image.path).first.crop_resized( options[:width].to_i, options[:height].to_i, Magick::NorthGravity ).write( write_path )
      url(im.filename)
    end
    
    def self.url( filename )
      "http://localhost:9999/api/images/#{File.basename(filename)}"
    end
    
    def self.file_write_path( filename )
      File.join(Convertify.storage_path, filename )
    end
    
    def self.validates_image( options = {} )
      if( !options[:file] || !options[:file].has_key?(:tempfile) )
        raise RequestException, 'Missing the file data to convert.'
      end
    end
    
  end
end