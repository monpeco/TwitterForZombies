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
