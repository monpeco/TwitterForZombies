require 'open-uri'
require 'nokogiri'
#require 'csv'

doc = Nokogiri::HTML(open("http://www.bari91.com"))

doc.xpath('/').each do |node|
  puts node
end
  


