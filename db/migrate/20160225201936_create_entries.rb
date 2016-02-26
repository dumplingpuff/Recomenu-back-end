class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :restaurant
      t.string :location
      t.string :dish
      t.text :content
      t.integer :rating

      t.timestamps null: false
    end
  end
end
