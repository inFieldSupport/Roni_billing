# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :company_name
      t.string :address
      t.string :email

      t.timestamps
    end
  end
end
