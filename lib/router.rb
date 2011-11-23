module Convertify
  module Router
    %w(javascripts stylesheets).each do |asset_type|
      content_type = asset_type == 'stylesheets' ? 'text/css' : 'text/javascript'
      get "/#{asset_type}/:file" do
        if params[:file]
          file_path = File.dirname(__FILE__) + "/../#{asset_type}/#{params[:file]}"
          if File.exists?( file_path )
            [200, {'Content-Type' => content_type}, File.read(file_path)]
          else
            [404, {'Content-Type' => content_type}, nil]
          end
        end
      end
    end
  end
end