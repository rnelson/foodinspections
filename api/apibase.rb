require 'sinatra/base'
require 'sinatra/config_file'

class ApiBase < Sinatra::Base
  @@enabled = false
  
  def self.enabled=(is_enabled)
    @@enabled = is_enabled
  end
  
  before do
    # Ensure this API is even enabled
    if not @@enabled
      halt 403, {'Content-Type' => 'text/plain'}, 'Yelp support disabled'
    end
    
    # Disallow remote access to authenticated third-party APIs
    if not '127.0.0.1' == request.ip.to_s
      halt 403, {'Content-Type' => 'text/plain'}, 'Access denied'
    end
  end
end