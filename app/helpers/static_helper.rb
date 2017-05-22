module StaticHelper

    # case-on-ranges
    def ageing age
        case age
          when -Float::INFINITY..20
            'You are too young'
          when 21..64
            'You are at the right age'
          when 65..Float::INFINITY
            'You are too old'
        end
    end
    


  def fibo num
    fibonacci = Hash.new{ |numbers,index|
      numbers[index] = fibonacci[index - 2] + fibonacci[index - 1]
    }.update(0 => 0, 1 => 1)
    
    fibonacci[num]
  end
  
  def using_fetch parameter
    my_hash = { "a" => "You send an \"a\"", "b" => "You send an \"b\"" }
    my_hash.fetch(parameter, "There is no \"#{parameter}\" key in the hash")
    
    # This will be the use of fetch with a block
    # my_hash.fetch(parameter) { |el| "go fish, #{el}"}
  end
  
  def reduce_plus       # Sum some numbers
    (5..10).reduce(:+)  #=> 45
  end
  
  def inject_plus       # Same using a block and inject
    (5..10).inject {|sum, n| sum + n }            #=> 45
  end
  
  def reduce_mult       # Multiply some numbers
    (5..10).reduce(1, :*)                         #=> 151200
  end

  def reduce_block# Same using a block
    (5..10).inject(1) {|product, n| product * n } #=> 151200
  end
  
end
