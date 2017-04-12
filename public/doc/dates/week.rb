require 'date'

datetime = "2017-04-12 10:30:14"

my_date = DateTime.parse(datetime).strftime("%d/%m/%Y")
my_hour = DateTime.parse(datetime).strftime("%H:%M")

puts my_date
puts my_hour

