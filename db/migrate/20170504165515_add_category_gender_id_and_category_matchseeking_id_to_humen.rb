class AddCategoryGenderIdAndCategoryMatchseekingIdToHumen < ActiveRecord::Migration
  def up
    add_column :humen, :category_gender_id, :integer
    add_column :humen, :category_matchseeking_id, :integer
  end
  def down
    remove_column :humen, :category_gender_id, :integer
    remove_column :humen, :category_matchseeking_id, :integer
  end  
end
