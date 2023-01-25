# frozen_string_literal: true

class AddColumnToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :month, :string
    add_column :users, :year, :integer
    add_column :standards, :month, :string
    add_column :standards, :year, :integer
    add_column :bills, :month, :string
    add_column :bills, :year, :integer
  end
end
