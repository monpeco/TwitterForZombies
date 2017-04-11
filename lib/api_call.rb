# lib/api_call.rb
require 'httparty'
require 'json'

API_URL = 'https://api.github.com/users/monpeco'

response = HTTParty.get(API_URL)

json = JSON.parse(response.body)

puts JSON.pretty_generate(json)

