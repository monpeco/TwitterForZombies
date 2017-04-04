#https://www.distilled.net/resources/web-scraping-with-ruby-and-nokogiri-for-beginners/

require 'httparty'
require 'nokogiri'
require 'pry'
require 'csv'

# this is how we request the page we're going to scrape
page = HTTParty.get('https://newyork.craigslist.org/search/pet?s=0')


# this is where we transform our http response into a nokogiri object so that we can parse it
parse_page = Nokogiri::HTML(page)

pets_array = []

#<title>new york pets  - craigslist</title>
puts parse_page.css("title")[0].text

#<a href="/mnh/pet/6072743772.html" data-id="6072743772" class="result-title hdrlnk">Loving Cat in need of New Home</a>
#links = parse_page.css('a')
puts parse_page.css("div").map do |a|
	post_name = a.text
	pets_array.push(post_name)
end


#puts parse_page.css("title")[0].text

# this is where we parse the data
"""
parse_page.css('.content').css('.row').css('.hdrlnk').map do |a|
	post_name = a.text
	pets_array.push(post_name)
end
"""

# this will push your array into a CSV file
CSV.open('pets.csv', 'w') do |csv|
	csv << pets_array
end

# Pry.start(binding)