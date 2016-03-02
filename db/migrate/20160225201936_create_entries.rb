
class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :restaurant, null: false
      t.string :location
      t.string :date
      t.string :time
      t.string :dish
      t.text :content
      t.integer :rating

      t.timestamps null: false
    end
  end
end
