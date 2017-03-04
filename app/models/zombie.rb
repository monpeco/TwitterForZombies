class Zombie < ActiveRecord::Base
    validates :name, presence: true, length: { minimum: 2 }
    validates :rotting, inclusion: { in: [true], message: 'no puede estar en false o nil' }
    validates :bio, exclusion: { in: %w(www us ca jp), message: "%{value} is reserved." }
    
    has_many :tweets, dependent: :destroy
end

