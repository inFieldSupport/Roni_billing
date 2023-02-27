class AddIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, [:user_type, :month, :year, :client_id], unique: true
  end
end
