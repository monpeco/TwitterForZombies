class Human < ActiveRecord::Base
    #https://rails-bestpractices.com/posts/2013/04/18/clever-enums-in-rails/
    POWERS = [POWER_FIST = 'fist', POWER_KICK = 'kick', POWER_GUN = 'gun']
    
    validates :power, inclusion: {in: POWERS}
    
    default_scope { where(fighting: true) }

    before_save :make_figthing
    
    validates :age, numericality: {greater_than_or_equal_to: 0, message: 'Este campo tiene que ser positivo' }
    
    scope :yongers, -> { where(age: 0..30) }    #lazy evaluated when it is called
    scope :with_power, -> (power) { where(power: power) }
    
    scope :active, -> (fighting) { where(fighting: fighting).order(:created_at) }

    scope :with_description, ->  { where.not(description: nil) }
    scope :without_description,  -> { where("humen.description IS NULL") }

    scope :gender, -> { where("category_gender_id != category_matchseeking_id" )  } 
    
    @current_user = 44
    Rails.logger.debug "@current_user,: #{@current_user}"
        
    def human_base(attribute)
        Human.find(attribute)
    end
    
    def make_figthing
       self.fighting = true if age > 21
    end
    
    def change_power
        self.power = Human::POWER_GUN
        save!
    end
    
end
