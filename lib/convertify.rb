require 'sinatra'
require 'RMagick'
require 'json'

require File.dirname(__FILE__) + '/api'
require File.dirname(__FILE__) + '/image'
require File.dirname(__FILE__) + '/router'

module Convertify
  class RequestException < Exception;end;
  
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
  end
end