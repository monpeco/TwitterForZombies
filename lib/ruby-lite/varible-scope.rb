#!/usr/bin/env ruby

@numHash = {}

def translate
  
  print "Number in English: "
  eng = gets.chomp
  print "eng: #{eng}\n"

  print "Numero en Espanol: "
  esp = gets.chomp
  print "esp: #{esp}\n"
  
  @numHash[eng] = esp
  puts "Data has been added!"
  puts @numHash
  
  translate
end



translate
