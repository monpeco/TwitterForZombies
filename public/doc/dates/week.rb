require 'date'

datetime = "2017-04-12 10:30:14"

my_date = DateTime.parse(datetime).strftime("%d/%m/%Y")
my_hour = DateTime.parse(datetime).strftime("%H:%M")

puts my_date
puts my_hour

puts "--------"

require 'active_support/core_ext/string'

datetime2 = "11/04/2017 23:00".to_time

my_date2 = datetime2.strftime("%d/%m/%Y")
my_hour2 = datetime2.strftime("%H:%M")

puts my_date2
puts my_hour2