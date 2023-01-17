class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :user_type
      t.float :user_rate
      t.integer :active_users
      t.integer :registered_users

      t.timestamps
    end
  end
end
