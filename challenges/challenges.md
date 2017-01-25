####RAILS NEW
####Enter the command to start a new rails app called 'ZombieTweets'
```ruby
$ rails new ZombieTweets

```

####GENERATE SCAFFOLD
####Enter the command to create tweet scaffold with a string status and an integer of zombie_id
```ruby
$ rails generate scaffold tweet status:string zombie_id:integer 


```

####CREATE TWEETS TABLE
####Write the migration manually which creates the tweets table in the database with the status string column and zombie_id integer column
```ruby
class CreateTweets < ActiveRecord::Migration
  def change
  end
end


```

```ruby
class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
    
      t.string :status
      t.integer :zombie_id
    
      t.timestamps null: false
    
    end
  end
end

```


####RUN MIGRATION
####Enter the command to run the migration you just created.


```ruby
$ rake db:migrate

```

####BOOT IT UP
####Enter the command to start a rails server

```ruby
$ rails server

```


####ADD COLUMN TO TABLE
####Enter the command line text to generate a migration called AddPrivacyToTweets which adds a boolean field called private.

```ruby
$ rails generate migration AddPrivacyToTweets private:boolean

```

####CREATE MIGRATION BY HAND
####Create migration by hand that adds two fields to the tweets table: a location string field which has a limit of 30 and a boolean field called show_location which defaults to false.
```ruby
class AddLocationToTweets < ActiveRecord::Migration
  def change

  end
end

```

```ruby
class AddLocationToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :location, :string, :limit => 30
    add_column :tweets, :show_location, :boolean, :default => false
  end
end

```

####ROLLBACK MIGRATION
####Assume we ran that last migration. However we forgot a column we wanted to add, could you please roll it back from the command line?
```ruby
$ rake db:rollback
```

####CHANGE TABLE
####Now that we've rolled back, add a category_name string field and use the rename command to rename the status column to message instead.

```ruby
lass AddLocationToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :location, :string, limit: 30
    add_column :tweets, :show_location, :boolean, default: false
  end 
end
```



```ruby
lass AddLocationToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :location, :string, limit: 30
    add_column :tweets, :show_location, :boolean, default: false
    add_column :tweets, :category_name, :string
    rename_column :tweets, :status, :message
  end 
end
```

####REMOVE COLUMN
####On second thought, that category_name string column was a bad idea. Write a migration to remove the category_name column.

```ruby
class RemoveCategoryNameFromTweets < ActiveRecord::Migration
  def up

  end

  def down

  end
end

```

```ruby
class RemoveCategoryNameFromTweets < ActiveRecord::Migration
  def up
    remove_column :tweets, :category_name
  end

  def down
    add_column :tweets, :category_name, :string
  end
end

```

####DATABASE SETUP
####You've decided to install the app on another computer. Please enter the command you should use (instead of rake db:migrate) to create the database, load the schema, and run the seed file.



```ruby
$ rake db:setup
```

####IN THE CONSOLE
####Enter the command to enter the Rails console


```ruby
$ rails console
```
####IN THE CONSOLE
Enter the command to enter the Rails console.
You are now running in the Rails console!
Experiment with creating a new Tweet and saving it to the database. Type next to move on.



```ruby
ruby > Model.column_names
    ["id", "message", "category_name", "location", "show_location", "zombie_id"]

Tweet.create(message: "this is a zombie writting", category_name: "low" , location: "GO", show_location: false, zombie_id: 1) 
```










