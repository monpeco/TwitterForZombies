require 'open-uri'
require 'nokogiri'
require 'csv'

doc = Nokogiri::HTML(open("http://www.google.com/search?q=doughnuts"))
doc.xpath('//h3/a').each do |node|
  puts node.text
end

puts '-----------------'

item_array = []
doc.xpath('//h3[@class = "r"]/a').each do |node|
  puts node.text
  item_array.push(node.text)
end

# this will push your array into a CSV file
CSV.open('pets.csv', 'w') do |csv|
	csv << item_array
end