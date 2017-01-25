##Name Scope

_File_: `app/controllers/rotting_zombies_controller.rb`

```ruby
class RottingZombiesController < ApplicationController

  def index
    @rotting_zombies = Zombie.where(rotting: true)
    ...
  end
  
end
```

If we are going to use this `where(rotting: true)` in several places, is better to move it to the model

`app/models/zombie.rb`
```ruby
class Zombie < ActiveRecord::Base

  scope :rotting, where(rotting: true)      #Defining the NAMED SCOPE
  
end
```

app/controllers/rotting_zombies_controller.rb
```ruby
class RottingZombiesController < ApplicationController

  def index
    @rotting_zombies = Zombie.rotting       #Using the NAMED SCOPE
    ...
  end
  
end
```

####Another examples of Named Scope
app/models/zombie.rb
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



