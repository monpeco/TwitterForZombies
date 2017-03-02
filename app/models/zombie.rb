class Zombie < ActiveRecord::Base
    validates :name, presence: true
    validates :rotting, acceptance: true
    validates :email, acceptance: true
end
