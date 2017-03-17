class Human < ActiveRecord::Base
    scope :yongers, -> { where(age: 0..30) }
    
    def human_base(attribute)
        Human.find(attribute)
    end
end
