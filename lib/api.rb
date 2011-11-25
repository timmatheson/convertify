module Convertify  
  module Api
    # Process a file
    post '/api/images/convert.json' do
      begin
        [200, {'Content-Type' => 'application/json'}, Convertify::Image.process( params ).to_json]
      rescue Convertify::RequestException => e
        [500, {'Content-Type' => 'application/json'}, {:error => e}.to_json]
      end
    end
    
    get '/api/images/:filename' do
      begin
        [200, {'Content-Type' => 'image/' + params[:filename].split(".").last}, Convertify.load_image(params[:filename])]
      rescue Errno::ENOENT => e
        # [404, {'Content-Type' => 'text/plain'}, 'You resquested a non existing image.']
        haml :"404"
      end
    end
  end
end