###Create rails app

```ruby
$ rails new TwitterForZombies
```

###Install dependencies
```ruby
$ bundle install
```

###List rails options
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

###Running Migrations
```ruby
$ rake db:migrate
    
    == 20170124184009 CreateZombies: migrating ====================================
    -- create_table(:zombies)
       -> 0.0010s
    == 20170124184009 CreateZombies: migrated (0.0011s) ===========================
```



###Rails Console
```ruby
$ rails console

    Zombie.create(name: "Eric A", age: 27)
        (0.1ms)  begin transaction
        SQL (0.4ms)  INSERT INTO "zombies" ("name", "age", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "Eric A"], ["age", 27], ["created_at", "2017-01-24 19:04:50.032077"], ["updated_at", "2017-01-24 19:04:50.032077"]]
        (9.9ms)  commit transaction
        => #<Zombie id: 1, name: "Eric A", bio: nil, age: 27, created_at: "2017-01-24 19:04:50", updated_at: "2017-01-24 19:04:50">

    z = Zombie.first
        Zombie Load (0.3ms)  SELECT  "zombies".* FROM "zombies"  ORDER BY "zombies"."id" ASC LIMIT 1
        => #<Zombie id: 1, name: "Eric A", bio: nil, age: 27, created_at: "2017-01-24 19:04:50", updated_at: "2017-01-24 19:04:50"> 
        
    z.name = "Caike S"    
        => "Caike S" 
        
    z.save    
        (0.1ms)  begin transaction
        SQL (0.3ms)  UPDATE "zombies" SET "name" = ?, "updated_at" = ? WHERE "zombies"."id" = ?  [["name", "Caike S"], ["updated_at", "2017-01-24 19:08:08.535456"], ["id", 1]]
        (9.7ms)  commit transaction
        => true 
```



###Rails Console
```ruby
$ rails console

    Zombie.create(name: "Eric A", age: 27)
        (0.1ms)  begin transaction
        SQL (0.4ms)  INSERT INTO "zombies" ("name", "age", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "Eric A"], ["age", 27], ["created_at", "2017-01-24 19:04:50.032077"], ["updated_at", "2017-01-24 19:04:50.032077"]]
        (9.9ms)  commit transaction
        => #<Zombie id: 1, name: "Eric A", bio: nil, age: 27, created_at: "2017-01-24 19:04:50", updated_at: "2017-01-24 19:04:50">

    z = Zombie.first
        Zombie Load (0.3ms)  SELECT  "zombies".* FROM "zombies"  ORDER BY "zombies"."id" ASC LIMIT 1
        => #<Zombie id: 1, name: "Eric A", bio: nil, age: 27, created_at: "2017-01-24 19:04:50", updated_at: "2017-01-24 19:04:50"> 
        
    z.name = "Caike S"    
        => "Caike S" 
        
    z.save    
        (0.1ms)  begin transaction
        SQL (0.3ms)  UPDATE "zombies" SET "name" = ?, "updated_at" = ? WHERE "zombies"."id" = ?  [["name", "Caike S"], ["updated_at", "2017-01-24 19:08:08.535456"], ["id", 1]]
        (9.7ms)  commit transaction
        => true 
```



###Adding columns
```ruby
$ rails g migration AddEmailAndRottingToZombie email:string rotting:boolean

    create    db/migrate/20170124222057_add_email_and_rotting_to_zombie.rb

```

####migration options:
```ruby
    default: <value>
    limit: 30
    null: false
    first: true     #postion in the table
    after: email
    unique: true
```
  
###Migration rake task
```ruby
$ rake db:migrate       #To run all missing migrations

$ rake db:rollback      #To rollback the previous migration

$ rake db:schema:dump       #Dump the current db state

$ rake db:setup       #Creates db, loads schema and seed

```

###Migration commands
```ruby
$ rails g migration RemoveAgeFromZombies age:integer

```

####Migration commands
```ruby
rename_column :zombies, :bio, :description
rename_table :zombies, :ghouls
drop_table :zombies
change_column :zombies, :age, :integer, limit: 4
change_column_default :zombies, is_admin, default: true
```

#### Other resources

* https://github.com/alemohamad/ruby-style-guide/blob/master/README-esLA.md
* https://github.com/thoughtbot/guides/tree/master/best-practices
* https://github.com/github/rubocop-github/blob/master/STYLEGUIDE.md
* https://github.com/franzejr/best-ruby

