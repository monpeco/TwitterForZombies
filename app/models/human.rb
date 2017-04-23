class Human < ActiveRecord::Base
    
    before_save :make_figthing
    
    validates :age, numericality: {greater_than_or_equal_to: 0, message: 'Este campo tiene que ser positivo' }
    
    scope :yongers, -> { where(age: 0..30) }    #lazy evaluated when it is called
    scope :with_power, -> (power) { where(power: power) }
    
    scope :with_description, ->  { where.not(description: nil) }
    scope :without_description,  -> { where("humen.description IS NULL") }

    
    @current_user = 44
    Rails.logger.debug "@current_user,: #{@current_user}"
        
    def human_base(attribute)
        Human.find(attribute)
    end
    
    def make_figthing
       self.fighting = true if age > 21
    end
end
