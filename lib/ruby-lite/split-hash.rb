hash = {"user:xy@xy.com password:azerty"=>1, "user:yy@yy.com password:qwerty"=>1}
hash.each { |x,y| puts x.split(" ").to_s.gsub("user:", "").to_s.gsub("password:", "") }

