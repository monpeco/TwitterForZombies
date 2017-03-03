#Relationships

###Use relationships to save a tweet from a zombie

    hilz = Zombie.find(8)
    #Zombie Load (0.3ms)  SELECT  "zombies".* FROM "zombies" WHERE "zombies"."id" = ? LIMIT 1  [["id", 8]]
    # => #<Zombie id: 8, name: "Hilary", bio: "My life was so great... not!", created_at: "2017-03-02 02:26:44", updated_at: "2017-03-02 02:26:44", email: nil, rotting: nil> 
    #
    t = Tweet.create(status: "delete your account", zombie: hilz)                                                                  
    #   (0.2ms)  begin transaction
    #INSERT INTO "tweets" ("status", "zombie_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["status", "delete your account"], ["zombie_id", 8], ["created_at", "2017-03-03 01:15:01.305733"], ["updated_at", "2017-03-03 01:15:01.305733"]]
    # => #<Tweet id: 6, status: "delete your account", body: nil, zombie_id: 8, created_at: "2017-03-03 01:15:01", updated_at: "2017-03-03 01:15:01">
    #
    hilz.tweets.count
    # SELECT COUNT(*) FROM "tweets" WHERE "tweets"."zombie_id" = ?  [["zombie_id", 8]]
    # => 1 
    #
    t = Tweet.find(6)
    # SELECT  "tweets".* FROM "tweets" WHERE "tweets"."id" = ? LIMIT 1  [["id", 6]]
    # => #<Tweet id: 6, status: "delete your account", body: nil, zombie_id: 8, created_at: "2017-03-03 01:15:01", updated_at: "2017-03-03 01:15:01"> 
    #
    t.zombie
    #  SELECT  "zombies".* FROM "zombies" WHERE "zombies"."id" = ? LIMIT 1  [["id", 8]]
    # => #<Zombie id: 8, name: "Hilary", bio: "My life was so great... not!", created_at: "2017-03-02 02:26:44", updated_at: "2017-03-02 02:26:44", email: nil, rotting: nil> 
    #
    t.zombie.name
    # => "Hilary" 
    #
    hilz.tweets
    #  SELECT "tweets".* FROM "tweets" WHERE "tweets"."zombie_id" = ?  [["zombie_id", 8]]
    # => #<ActiveRecord::Associations::CollectionProxy [#<Tweet id: 6, status: "delete your account", body: nil, zombie_id: 8, created_at: "2017-03-03 01:15:01", updated_at: "2017-03-03 01:15:01">]> 

##1 Why Associations?

####Creating a tweet for a particular zombie
    mark = Zombie.find(5)
    #   SELECT  "zombies".* FROM "zombies" WHERE "zombies"."id" = ? LIMIT 1  [["id", 5]]
    #   => #<Zombie id: 5, name: "Mark", bio: "This is so cold", created_at: "2017-03-01 02:41:56", updated_at: "2017-03-01 12:44:44", email: "another@rotting.com", rotting: true> 
    #
    mark.tweets.create(status: "This is a tweet from the zombie Mark")                                                                                    
    #   INSERT INTO "tweets" ("status", "zombie_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["status", "This is a tweet from the zombie Mark"], ["zombie_id", 5], ["created_at", "2017-03-03 12:23:36.447280"], ["updated_at", "2017-03-03 12:23:36.447280"]]
    #   => #<Tweet id: 7, status: "This is a tweet from the zombie Mark", body: nil, zombie_id: 5, created_at: "2017-03-03 12:23:36", updated_at: "2017-03-03 12:23:36"> 


####Deleting an zombie and all of its tweets:

    mark.destroy
    DELETE FROM "tweets" WHERE "tweets"."id" = ?  [["id", 7]]
    DELETE FROM "zombies" WHERE "zombies"."id" = ?  [["id", 5]]
    #   => #<Zombie id: 5, name: "Mark", bio: "This is so cold", created_at: "2017-03-01 02:41:56", updated_at: "2017-03-01 12:44:44", email: "another@rotting.com", rotting: true>
    
##2 The Types of Associations
    
    belongs_to
    has_one
    has_many
    has_many :through
    has_one :through
    has_and_belongs_to_many
    
book model this way

    class Book < ApplicationRecord
      belongs_to :author
    end


The corresponding migration 

    class CreateBooks < ActiveRecord::Migration[5.0]
      def change
        create_table :authors do |t|
          t.string :name
          t.timestamps
        end
     
        create_table :books do |t|
          t.belongs_to :author, index: true
          t.datetime :published_at
          t.timestamps
        end
      end
    end
    
####2.3 The has_many Association

class Author < ApplicationRecord
  has_many :books
end

The corresponding migration:

    class CreateAuthors < ActiveRecord::Migration[5.0]
      def change
        create_table :authors do |t|
          t.string :name
          t.timestamps
        end
     
        create_table :books do |t|
          t.belongs_to :author, index: true
          t.datetime :published_at
          t.timestamps
        end
      end
    end


####2.4 The has_many :through Association

For example, consider a medical practice where patients make appointments to see physicians. The relevant association declarations could look like this:

    class Physician < ApplicationRecord
      has_many :appointments
      has_many :patients, through: :appointments
    end
     
    class Appointment < ApplicationRecord
      belongs_to :physician
      belongs_to :patient
    end
     
    class Patient < ApplicationRecord
      has_many :appointments
      has_many :physicians, through: :appointments
    end

The corresponding migration might look like this:

    class CreateAppointments < ActiveRecord::Migration[5.0]
      def change
        create_table :physicians do |t|
          t.string :name
          t.timestamps
        end
     
        create_table :patients do |t|
          t.string :name
          t.timestamps
        end
     
        create_table :appointments do |t|
          t.belongs_to :physician, index: true
          t.belongs_to :patient, index: true
          t.datetime :appointment_date
          t.timestamps
        end
      end
    end

The has_many `:through` association is also useful for setting up "shortcuts" through nested `has_many` associations. For example, if a document has many sections, and a section has many paragraphs, you may sometimes want to get a simple collection of all paragraphs in the document. You could set that up this way:

    class Document < ApplicationRecord
      has_many :sections
      has_many :paragraphs, through: :sections
    end
     
    class Section < ApplicationRecord
      belongs_to :document
      has_many :paragraphs
    end
     
    class Paragraph < ApplicationRecord
      belongs_to :section
    end
    With through: :sections specified, Rails will now understand:
    
    @document.paragraphs

