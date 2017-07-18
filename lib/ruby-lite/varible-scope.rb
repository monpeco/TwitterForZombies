def getAnagramIndices(haystack, needle)
    # WRITE YOUR CODE HERE
    result = []
    index = []
    
    str1_len = haystack.length
    str2_len = needle.length
    
    haystack.split("").each_with_index  do | x, i |
      if needle.include? x
        #puts i
        index.push(i)
      end
    end

    puts "buscar"

    index.each do | i |
      #puts "i: #{i}, str2_len: #{str2_len}"
      aux_hay = haystack[(i)..(i+str2_len-1)]
      puts "aux_hay: #{aux_hay}, index: #{i}"
      is_ana = true
      used = ""
      aux_hay.split("").each do | x |
        puts "x: - #{x}"
        
        if (needle.include?(x)) and (used.include?(x))
          #is_ana = true
          used+=x
          puts "TRUE"
        else
          is_ana = false
          puts "FALSE. x:#{x}"        
        end
      end
      puts "fin if"
      if (is_ana) 
        result.push(i)
      end
      #if i == 6
       # break
      #end
    end
    
    puts "result.length: #{result.length}"
    
    puts "result item"
    result.each do |x|
      puts x
    end
end

puts "inicio"

getAnagramIndices("abdcghbaabcdij", "bcda")

