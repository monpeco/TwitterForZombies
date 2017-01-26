##Name Scope

_*File*_: `app/controllers/rotting_zombies_controller.rb`

```ruby
class RottingZombiesController < ApplicationController

  def index
    @rotting_zombies = Zombie.where(rotting: true)
    ...
  end
  
end
```

If we are going to use this `where(rotting: true)` in several places, is better to move it to the model

_*File*_: `app/models/zombie.rb`
```ruby
class Zombie < ActiveRecord::Base

  scope :rotting, where(rotting: true)      #Defining the NAMED SCOPE
  
end
```

_*File*_: `app/controllers/rotting_zombies_controller.rb`
```ruby
class RottingZombiesController < ApplicationController

  def index
    @rotting_zombies = Zombie.rotting       #Using the NAMED SCOPE
    ...
  end
  
end
```

####Another examples of Named Scope
_*File*_: `app/models/zombie.rb`
```ruby
class Zombie < ActiveRecord::Base

  scope :rotting, where(rotting: true)
  scope :fresh, where("age < 20")                   #All zombies with age of 20 or lower
  scope :recent, where("created_at desc").limit(3)  #3 zombies most reciented

end
```

####Using method chaining to create queries

```ruby
Zpmbie.rotting.limit(5)

Zombie.recent.rotting

Zombie.recent.fresh.rotting
```

##Callbacks
Objetive: When zombie age > 20, set rotting to true

_*File*_: `app/controllers/rotting_zombies_controller.rb`
```ruby

def update
  @zombie = Zombie.find(params[:id]) 

  if @zombie.age > 20           #Bad code
      @zombie.rotting = true
  end

  respond_to do |format|
    if @zombie.update_attributes(params[:zombie])
      ...
    else
      ...
    end
end
```

It is bad code, because It can be another places where the age migth be updated (or saved), and this code will ignore those places


_*File*_: `app/models/zombie.rb`
```ruby
class Zombie < ActiveRecord::Base
  beffore_save :make_rotting
  
  def make_rotting
    if age > 20           #Good code
        self.rotting = true
    end    
  end

end
```

Refactoring
```ruby
class Zombie < ActiveRecord::Base
  beffore_save :make_rotting
  
  def make_rotting
    self.rotting = true if age > 20   
  end

end
```

##Returning false will halt
_*File*_: `app/models/brail.rb`
```ruby
class Brain < ActiveRecord::Base
  before_save :taste    #Save stops if callback return false
  
  def taste
    return false  
  end

end
```
```ruby
rails console

  ruby > b = Brain.new(:flavor => 'butter')
         b.saved
         => false
```
It will never save, because taste callback is returning false everytime

####All callbacks
```ruby
before_validation
after_validation

before_save
after_save

before_create
after_create

before_update
after_update

before_destroy
after_destroy

```

####Observations

  1. Can use multiple callbacks (even of the same type)
  2. If any of this return false, everythin is going to stop

####Real life examples

  1. `after_create :send_welcome_email`
  2. `before_save :encrypt_password`
  3. `before_destroy :set_deleted_flag`

##has_one
Objetive: A zombie may or may not have a (single) brain

```ruby
$ rails g model brain zombie_id:integer status:string flavor:string
```
_*File*_: `db/migrate/20170125101010_create_brains.rb`
```ruby
class CreateBrains < ActiveRecord::Migration
  def change
    create_table :brains do |t|
      t.integer :zombie_id
      t.string :status
      t.string :flavor
    end
    
    add_index :brains, :zombie_id     #add a foreign_key index
  end

```
Then run migration
```ruby
$ rake db:migrate
```

####Represent tables relation
_*File*_: `app/models/brain.rb`
```ruby
class Brain < ActiveRecord::Base
  belongs_to :zombie
end
```

_*File*_: `app/models/zombie.rb`
```ruby
class Zombie < ActiveRecord::Base
  has_one :brain
end
```

```ruby
$ rails console
  rails > z = Zombie.last
        => #Zombie id: 1, name: "Eric Allam", bio: nil, age: 27
        
  rails > z.create_brain(status: "Squashed", flavor: "Mud")
        => #Brain id: 1, zombie_id: 1, status: "Squashed", flavor: "Mud"
        
  rails > z.brain
        => #Brain id: 1, zombie_id: 1, status: "Squashed", flavor: "Mud"

```

####Whhat happend when we destroy zombie
```ruby
$ rails console
  rails > z = Zombie.find(1)
        => #Zombie id: 1, name: "Eric Allam", bio: nil, age: 27
        
  rails > Brain.find(1)
        => #Brain id: 1, zombie_id: 1, status: "Squashed", flavor: "Mud"

  rails > z.destroy
        => #Zombie id: 1, name: "Eric Allam", bio: nil, age: 27

  rails > Brain.find(1)
        => #Brain id: 1, zombie_id: 1, status: "Squashed", flavor: "Mud"

```

The brain remains after the zombie is destroyed. Lets fix that.
_*File*_: `app/models/zombie.rb`
```ruby
class Zombie < ActiveRecord::Base
  has_one :brain, dependent: :destroy
end
```

```ruby
$ rails console
  rails > z = Zombie.find(1)
        => #Zombie id: 1, name: "Eric Allam", bio: nil, age: 27
        
  rails > z.destroy
        => #Zombie id: 1, name: "Eric Allam", bio: nil, age: 27

  rails > Brain.find(1)
        => #Brain id: 1, zombie_id: 1, status: "Squashed", flavor: "Mud"

```
And in this way, both zombie and brain are destoyed.

####Relationship options

|Relationship|Description|
|------------|-----------|
|`dependent: :destroy`|will cal destroy on associated objects|
|`foreign_key: :undead_id`|will cal destroy on associated objects|
|`primary_key: :zid`|change the primary key|
|`validate: true`|when zombie validates brain will to|

####Relationship "include" option

|Name|Brain Flavor|
|----|------------|
|Joe|Mud|
|Jim|Strawberry|
|Bob|Butter|
|Tony|Bubble Gum|

_*File*_: `app/controllers/zombies_controller.rb`

```ruby
def index
  @zombies = Zombie.all
```


_*File*_: `app/views/zombies/index.html.erb`

```ruby
<% @zombies.each do |zombie| %>
  <tr>
    <td><%= zombie.name %></td>
    <td><%= zombie.brain.flavor %></td>
  </tr>
<% end %>

```

Server runs (a N+1 query)
```
Zombie load (0.1ms) SELECT * FROM "zombies"
  Brain load (0.2ms) SELECT * FROM "brains" WHERE "zombie_id" = 4
  Brain load (0.2ms) SELECT * FROM "brains" WHERE "zombie_id" = 5
  Brain load (0.2ms) SELECT * FROM "brains" WHERE "zombie_id" = 6
  Brain load (0.2ms) SELECT * FROM "brains" WHERE "zombie_id" = 7

```

How we fix this? with the `includes` option

_*File*_: `app/controllers/zombies_controller.rb`

```ruby
def index
  @zombies = Zombie.includes(:brain).all
```


_*File*_: `app/views/zombies/index.html.erb`

```ruby
<% @zombies.each do |zombie| %>
  <tr>
    <td><%= zombie.name %></td>
    <td><%= zombie.brain.flavor %></td>
  </tr>
<% end %>

```

Server runs 
```
Zombie load (0.1ms) SELECT * FROM "zombies"
  Brain load (0.3ms) SELECT * FROM "brains" WHERE "zombie_id" IN(4, 5, 6, 7)

```

##Has_many :through









