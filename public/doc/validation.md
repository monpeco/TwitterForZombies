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

    validates :rotting, inclusion: { in: [true], message: 'no puede estar en false o nil' }

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

####Validates minimun

    b = Zombie.new(name: "X", rotting: true)
    #=> #<Zombie id: nil, name: "X", bio: nil, created_at: nil, updated_at: nil, email: nil, rotting: true> 
    b.save
    # => false 
    b.errors.messages
    # => {:name=>["is too short (minimum is 2 characters)"]} 

    z = Zombie.new(name: "Alison Smith", rotting: true)
    => #<Zombie id: nil, name: "Alison Smith", bio: nil, created_at: nil, updated_at: nil, email: nil, rotting: true> 
    z.save
    => false 
    z.errors.messages
     => {:name=>["is too long (maximum is 5 characters)"]} 


    z = Zombie.new(name: "Joe", rotting: true, email: "hjhjh")
    # => #<Zombie id: nil, name: "Joe", bio: nil, created_at: nil, updated_at: nil, email: "hjhjh", rotting: true> 
    #
    z.valid?                                                                                                                                                                         
    # => false 
    #
    z.errors.messages
    # => {:base=>["provide a proper email"]} 


    z = Zombie.new(name: "Joe", rotting: true, email: "example@example.com")
    # => #<Zombie id: nil, name: "Joe", bio: nil, created_at: nil, updated_at: nil, email: "example@example.com", rotting: true> 
    #
    z.valid?
    # => true
    #
    z.save
    INSERT INTO "zombies" ("name", "rotting", "email", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["name", "Joe"], ["rotting", "t"], ["email", "example@example.com"], ["created_at", "2017-03-06 14:09:06.478259"], ["updated_at", "2017-03-06 14:09:06.478259"]]
    # => true 
    
####The rails 3 way to add custom validation

    include ActiveModel::Validations
    
    class TitleValidator < ActiveModel::EachValidator
      def validate_each(record, attribute, value)
        record.errors.add attribute, "must start with 'the'" unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i 
      end
    end

####Define a controller method and call it from console

    ZombiesController.new.other_option
    SELECT "zombies".* FROM "zombies"
    # => [["Caike S", "1"], ["Ash", "2"], ["Bob", "3"], ["Mike", "4"], ["Alice", "6"], ["Joseph", "7"], ["Hilary", "8"], ["Doug", "9"], ["Romano", "10"], ["Patton", "11"], ["June", "12"], ["Bi", "13"], ["Joe", "14"]] 
 
 