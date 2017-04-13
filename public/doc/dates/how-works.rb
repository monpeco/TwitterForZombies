require "time"

Time.parse("Dec 8 2015 10:19")
#=> 2015-12-08 10:19:00 +0000

Date.parse("Dec 8 2015")
#=> Tue, 08 Dec 2015

Time.new(2015, 12, 8, 10, 19)
#=> 2015-12-08 10:19:00 +0000

Date.new(2015, 12, 8)
#=> Tue, 08 Dec 2015


#Add time
time = Time.now
#=> 2017-04-13 16:36:20 +0000

time + 3600
#=> 2017-04-13 17:36:20 +0000

#Working with time zones
ENV["TZ"]
#=> nil

Time.now
#=> 2017-04-13 16:38:23 +0000

ENV["TZ"] = "America/Los_Angeles"
#=> "America/Los_Angeles"

Time.now
#=> 2017-04-13 09:38:23 -0700




"""
But in postgres

SELECT current_setting('timezone');
=> Brazil/East

You’re better off avoiding the time zone in all pieces of your infrastructure; instead of 
using a specific time zone, just go with Etc/UTC. This will free you from problems related 
to DST and cron jobs. It will also be easier to define how different systems will work with 
dates and communicate. The time zone presentation should be the application’s responsibility.
"""





