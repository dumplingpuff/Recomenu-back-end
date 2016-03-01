class AddUserToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :user_id, :integer
    add_index :entries, :user_id
    add_foreign_key :entries, :users, column: :user_id
  end
end
