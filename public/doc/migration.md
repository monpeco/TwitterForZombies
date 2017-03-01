#Active Record Migrations  
> http://guides.rubyonrails.org/active_record_migrations.html  

###2 Creating a Migration

Running:    
    rails generate migration AddPartNumberToProducts

Produces:

    class AddPartNumberToProducts < ActiveRecord::Migration[5.0]
      def change
      end
    end

Running:    
    rails generate migration AddPartNumberToProducts part_number:string

Produces:

    class AddPartNumberToProducts < ActiveRecord::Migration[5.0]
      def change
        add_column :products, :part_number, :string
      end
    end
    
### to add an index on the new column

Running: 
 
    rails generate migration AddPartNumberToProducts part_number:string:index

Produces:

    class AddPartNumberToProducts < ActiveRecord::Migration[5.0]
      def change
        add_column :products, :part_number, :string
        add_index :products, :part_number
      end
    end

###to remove a column

Running: 
 
    rails generate migration RemovePartNumberFromProducts part_number:string

Produces:

    class RemovePartNumberFromProducts < ActiveRecord::Migration[5.0]
      def change
        remove_column :products, :part_number, :string
      end
    end

###migration creating the table
If the migration name is of the form "CreateXXX" and is followed by a list of column names and types then a migration creating the table XXX with the columns listed will be generated.

running:

    rails generate migration CreateProducts name:string part_number:string

generates:

    class CreateProducts < ActiveRecord::Migration[5.0]
      def change
        create_table :products do |t|
          t.string :name
          t.string :part_number
        end
      end
    end

###column type as references(also available as belongs_to)

Running:

    rails generate migration AddUserRefToProducts user:references

Generates:

    class AddUserRefToProducts < ActiveRecord::Migration[5.0]
      def change
        add_reference :products, :user, index: true, foreign_key: true
      end
    end

##When Helpers aren't Enough

    Product.connection.execute("UPDATE products SET price = 'free' WHERE 1=1")
    
##Using the up/down Methods


class ExampleMigration < ActiveRecord::Migration[5.0]
  def up
    create_table :distributors do |t|
      t.string :zipcode
    end
 
    add_column :users, :home_page_url, :string
    rename_column :users, :email, :email_address
  end
 
  def down
    rename_column :users, :email_address, :email
    remove_column :users, :home_page_url

    drop_table :distributors
  end
end

##Reverting Previous Migrations

    require_relative '20121212123456_example_migration'
     
    class FixupExampleMigration < ActiveRecord::Migration[5.0]
      def change
        revert ExampleMigration
     
        create_table(:apples) do |t|
          t.string :variety
        end
      end
    end
    
#4 Running Migrations

The very first migration related bin/rails task you will use will probably be rails  

    $ db:migrate

runs the `change` or `up` method 

Running the `db:migrate` task also invokes the `db:schema:dump` task, which will update your `db/schema.rb` file to match the structure of your database.

If you specify a target version, Active Record will run the required migrations (change, up, down) until it has reached the specified version. 

    $ bin/rails db:migrate VERSION=20080906120000
    
###4.1 Rolling Back

    $ rails db:rollback

This will rollback the latest migration, either by reverting the _*change*_ method or by running the _*down*_ method

If you need to undo several migrations you can provide a STEP parameter:

    $ rails db:rollback STEP=3
    
###4.2 Setup the Database

The rails `db:setup` task will create the database, load the schema and initialize it with the seed data.

###4.3 Resetting the Database

The rails `db:reset` task will drop the database and set it up again. This is functionally equivalent to rails `db:drop` `db:setup`.

###4.4 Running Specific Migrations

If you need to run a specific migration `up` or `down`, the `db:migrate:up` and `db:migrate:down` tasks will do that. 
Just specify the appropriate version and the corresponding migration will have its change, `up` or `down` method invoked, for example:

    $ rails db:migrate:up VERSION=20080906120000