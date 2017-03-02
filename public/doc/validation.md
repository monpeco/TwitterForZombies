#1 Validations

    z = Zombie.new(name: "Hilary", bio: "My life was so great... not!")
    # => #<Zombie id: nil, name: "Hilary", bio: "My life was so great... not!", created_at: nil, updated_at: nil, email: nil, rotting: nil> 
    z.new_record?
    # => true 
    z.save
    #INSERT INTO "zombies" ("name", "bio", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "Hilary"], ["bio", "My life was so great... not!"], ["created_at", "2017-03-02 02:26:44.735739"], ["updated_at", "2017-03-02 02:26:44.735739"]]
    # => true 
    z.new_record?
    # => false
    
####1.3 Skipping Validations
The following methods skip validations, and will save the object to the database regardless of its validity. They should be used with caution.

    decrement!
    decrement_counter
    increment!
    increment_counter
    toggle!
    touch
    update_all
    update_attribute
    update_column
    update_columns
    update_counters

Note that save also has the ability to skip validations if passed `validate:
false` as an argument. This technique should be used with caution.

    save(validate: false)

####1.4 valid? and invalid?
You can also run these validations on your own. `valid?` triggers your validations and returns true if no errors were found in the object, and false otherwise.

    z = Zombie.new(name: "Alan B").valid?
    # => true 
    #
    z = Zombie.new(bio: "missing name").valid?                                                                                   
    # => false 
    #
    z = Zombie.new(bio: "Missing name")
    z.errors.messages
    # => {} 
    #
    z.save
       (0.4ms)  begin transaction
       (0.2ms)  rollback transaction
     => false 
     z.errors.messages
    => {:name=>["can't be blank"]} 
    