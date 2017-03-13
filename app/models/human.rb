class Human < ActiveRecord::Base
    def human_base(attribute)
        Human.find(attribute)
    end
end
