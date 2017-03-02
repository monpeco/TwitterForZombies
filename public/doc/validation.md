#1 Validations

> http://guides.rubyonrails.org/active_record_validations.html

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
    

##2 Validation Helpers

####2.1 acceptance

    validates :rotting, acceptance: true
    validates :email, acceptance: true
    
###To recover all validations
    
    Zombie.validators
    
###Inlusion (not working for me acceptance with bool)

    z = Zombie.new(bio: "This is it")
    # => #<Zombie id: nil, name: nil, bio: "This is it", created_at: nil, updated_at: nil, email: nil, rotting: nil> 
    #
    z.save
    # => false 
    # 
    z.errors.messages
    # => {:rotting=>["no puede estar en false o nil"]} 

###exclusion

    validates :bio, exclusion: { in: %w(www us ca jp), message: "%{value} is reserved." }

    z = Zombie.new(bio: "www")
    #<Zombie id: nil, name: nil, bio: "www", created_at: nil, updated_at: nil, email: nil, rotting: nil> 
    #
    z.save
    # => false 
    #
    z.errors.messages
    # => {:name=>["can't be blank"], :rotting=>["no puede estar en false o nil"], :bio=>["www is reserved."]} 


