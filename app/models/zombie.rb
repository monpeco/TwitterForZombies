class Zombie < ActiveRecord::Base
    #validates :name, presence: true, 
    #length: {minimum: 2, maximum: 5}
    #validates :rotting, inclusion: { in: [true], message: 'no puede estar en false o nil' }
    #validates :bio, exclusion: { in: %w(www us ca jp), message: "%{value} is reserved." }
    
    has_many :tweets, dependent: :destroy
    
    #validates :email, presence: true, email: true
    
    def create_tweets(attribute)
        attribute['zombie_id'] = self.id
        Tweet.create(attribute)
    end
end

