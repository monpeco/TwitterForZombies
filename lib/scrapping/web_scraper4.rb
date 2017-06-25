require 'open-uri'
require 'nokogiri'
#require 'csv'

#doc = Nokogiri::HTML(open("http://www.bari91.com"))
file = File.read('./lib/scrapping/doc.xml')
doc = Nokogiri::XML(file)
#puts doc


#doc.css('title').each do |item|
#  puts item
#end

doc.css('/').each do |item|
  #puts item
  #puts item.attribute("title")
  item.attributes.each do |name|
     # name is a string
     # attr is a Nokogiri::XML::Attr
    p name 
  end
end
