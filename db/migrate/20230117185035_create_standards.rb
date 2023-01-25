# frozen_string_literal: true

class CreateStandards < ActiveRecord::Migration[7.0]
  def change
    create_table :standards do |t|
      t.string :standard_type
      t.float :standard_rate
      t.integer :active_users
      t.integer :registered_users
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
