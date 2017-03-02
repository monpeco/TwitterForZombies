class Zombie < ActiveRecord::Base
    validates :name, presence: true
    validates :rotting, inclusion: { in: [true], message: 'no puede estar en false o nil' }
end

