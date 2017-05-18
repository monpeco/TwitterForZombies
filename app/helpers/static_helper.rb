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
    
end
