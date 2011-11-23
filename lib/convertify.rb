require 'sinatra'
require 'RMagick'
require 'json'

require File.dirname(__FILE__) + '/api'
require File.dirname(__FILE__) + '/image'

module Convertify
  class RequestException < Exception;end;
  
  class Application < Sinatra::Application
    set :views, File.dirname(__FILE__) + '/../views'
    
    # All routes
    get '/' do
      haml :index
    end
    
    get '/api' do
      haml :api
    end
    
    get '/stylesheets/:file' do
      if params[:file]
        file_path = File.dirname(__FILE__) + "/../stylesheets/#{params[:file]}"
        if File.exists?( file_path )
          [200, {'Content-Type' => 'text/css'}, File.read(file_path)]
        else
          [404, {'Content-Type' => 'text/css'}, nil]
        end
      end
    end

    # Process a file
    post '/api/images/convert.json' do
      begin
        [200, {'Content-Type' => 'application/json'}, Convertify::Image.process( params ).to_json]
      rescue Convertify::RequestException => e
        [500, {'Content-Type' => 'application/json'}, {:error => e}.to_json]
      end
    end
  end
end