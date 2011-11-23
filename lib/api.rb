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
  end
end