require "time"

Time.parse("Dec 8 2015 10:19")
#=> 2015-12-08 10:19:00 +0000

Date.parse("Dec 8 2015")
#=> Tue, 08 Dec 2015

Time.new(2015, 12, 8, 10, 19)
#=> 2015-12-08 10:19:00 +0000

Date.new(2015, 12, 8)
#=> Tue, 08 Dec 2015

