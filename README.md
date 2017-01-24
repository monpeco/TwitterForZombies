###Create rails app

```ruby
$ rails new TwitterForZombies
```

###Instal dependencies
```ruby
$ bundle install
```

###List rails option
```ruby
$ rails

    The most common rails commands are:
     generate    Generate new code (short-cut alias: "g")
     console     Start the Rails console (short-cut alias: "c")
     server      Start the Rails server (short-cut alias: "s")
     dbconsole   Start a console for the database specified in config/database.yml
                 (short-cut alias: "db")
```

###Run server
```ruby
$ rails server

```
###Rails generator
```ruby
$ rails generate

  assets
  controller
  generator
  helper
  mailer
  migration
  model
  scaffold
```
###Starting with scaffold
```ruby
$ rails generate scaffold


```

###Starting with scaffold
```ruby
$ rails generate scaffold zombie name:string bio:text age:integer

      invoke  active_record                                 #Model
      create    db/migrate/20170124184009_create_zombies.rb
      create    app/models/zombie.rb
      
      route    resources :zombies                           #Routing
      
      create    app/controllers/zombies_controller.rb       #Controller
      
      create      app/views/zombies                         #Views
      create      app/views/zombies/index.html.erb
      create      app/views/zombies/edit.html.erb
      create      app/views/zombies/show.html.erb
      create      app/views/zombies/new.html.erb
      create      app/views/zombies/_form.html.erb
```


