class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name
      t.integer :score

      t.timestamps null: false
    end
  end
end
