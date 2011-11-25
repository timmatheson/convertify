require 'sinatra'
require 'RMagick'
require 'json'

require File.dirname(__FILE__) + '/api'
require File.dirname(__FILE__) + '/image'
require File.dirname(__FILE__) + '/router'

module Convertify
  class RequestException < Exception;end;
  
  def self.storage_path
    # @@storage_path ||= File.join(File.dirname(__FILE__), '..', 'images')
    @@storage_path ||= Dir.tmpdir
  end
  
  def self.load_image( filename )
    File.read( File.join( storage_path, filename ) )
  end
  
  class Application < Sinatra::Application
    # Adds the routes used for Api Requests
    include Api
    include Router
    
    # All routes
    get '/' do
      haml :index
    end
    
    get '/api' do
      haml :api
    end
    
    get '/500.html' do
      haml :"500"
    end
    
    get '/404.html' do
      haml :"404"
    end
  end
end