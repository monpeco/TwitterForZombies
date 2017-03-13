# lib/url_api.rb
require 'httparty'

# irb
# require "./url_api"
# u = UrlApi.new.unique_url

class UrlApi
  API_URL = 'https://api.github.com/users/monpeco?fields=login'
  #API_URL = 'https://graph.facebook.com/youtube?fields=error'

  def unique_url
    response = HTTParty.get(API_URL)
    # TODO more error checking (500 error, etc)
    json = JSON.parse(response.body)
    
    puts JSON.pretty_generate(json)
    
    json['url']
  end
end