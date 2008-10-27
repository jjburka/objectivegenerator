require 'open-uri'
# By default the connection will send 
#
# Accept: application/xml
# Content-Type: application/xml
#


# Handles the connection to the resource server
# 
# arugments passed in are
#
# :url                        => the full url to the resource
# :authentication  => [<user_name> , <password>]
# 
# any other values will be added the the connection has header fields

class ActiveResourceConnection
  
  attr_reader :url
  attr_reader :result
  attr_reader :headers
  
  def initialize(args = {})
    
    @url = args.delete(:url)
    raise OpenURI::HTTPError.new("Url can not be blank",nil) if @url.nil?
    
    @headers = args;
    @headers["Accept"] = "application/xml"
    @headers["Content-Type"] = "application/xml"
    @headers[:http_basic_authentication] = args[:authentication] unless args[:authentication].nil?
  end
  
  # connects to the server and gets the data
  def fetch()
    @result = open(@url,@headers)
  end
  
  
end