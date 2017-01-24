class RemoveAgeFromZombies < ActiveRecord::Migration
  def up
    remove_column :zombies, :age, :integer
  end
  
  def down
    add_column :zombies, :age, :integer
  end  
end
