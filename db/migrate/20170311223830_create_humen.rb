class CreateHumen < ActiveRecord::Migration
  def change
    create_table :humen do |t|
      t.string :name
      t.string :power
      t.integer :age
      t.text :description
      t.boolean :fighting

      t.timestamps null: false
    end
  end
end
