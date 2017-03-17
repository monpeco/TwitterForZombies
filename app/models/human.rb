class Human < ActiveRecord::Base
    scope :yongers, -> { where(age: 0..30) }    #lazy evaluated when it is called
    scope :with_power, -> (power) { where(power: power) }
    
    def human_base(attribute)
        Human.find(attribute)
    end
end
