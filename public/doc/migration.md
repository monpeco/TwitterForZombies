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
    
    