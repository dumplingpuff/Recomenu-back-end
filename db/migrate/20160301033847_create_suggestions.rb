class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :name ,null: false
      t.string :restaurant, null: false
      t.string :location
      t.string :dish
      t.string :votes
      t.string :status

      t.timestamps null: false
    end
    add_index :suggestions, :restaurant, unique: true
  end
end
