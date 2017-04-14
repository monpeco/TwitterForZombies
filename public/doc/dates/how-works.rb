#http://nandovieira.com/working-with-dates-on-ruby-on-rails

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


#How Ruby on Rails works

# config/initializers/time_zone.rb
Time.zone = "America/Sao_Paulo"

"""
Ruby on Rails can have a time zone configuration per application, totally ignoring the TZ 
environment variable, but this behavior has some implications.

First, Ruby won’t consider Rails’ time zone configuration. This means that if your system 
is using the America/Sao_Paulo time zone and your application is using America/Los_Angeles, 
Ruby will still consider the former configuration.
"""

Time.now.zone
#=> "BRST"

Time.zone = "America/Los_Angeles"
#=> "America/Los_Angeles"

Time.now.zone
#=> "BRST"

"""
To generate dates that knows about the time zone, you should use methods defined by 
the ActiveSupport library. These methods will generate objects from the 
ActiveSupport::TimeWithZone3 class. There are a large number of methods and their 
usage will depend on what you want to accomplish.

"""

Time.zone.now
#=> Thu, 13 Apr 2017 09:49:43 PDT -07:00

Time.zone.today
#=> Thu, 13 Apr 2017

Time.current
#=> Thu, 13 Apr 2017 09:49:43 PDT -07:00

1.hour.ago
#=> Thu, 13 Apr 2017 08:49:43 PDT -07:00

1.day.from_now
#=> Fri, 14 Apr 2017 09:49:43 PDT -07:00

Date.yesterday
#=> Wed, 12 Apr 2017

Date.tomorrow
#=> Fri, 14 Apr 2017

#The general guidelines are:

Use Time.current #instead of Time.now.
Use Date.current #instead of Date.today.

