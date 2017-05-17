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
    
    
end
