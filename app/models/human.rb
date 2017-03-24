class Human < ActiveRecord::Base
    scope :yongers, -> { where(age: 0..30) }    #lazy evaluated when it is called
    scope :with_power, -> (power) { where(power: power) }
    
    @current_user = 44
    Rails.logger.debug "@current_user,: #{@current_user}"
        
    def human_base(attribute)
        Human.find(attribute)
    end
end
