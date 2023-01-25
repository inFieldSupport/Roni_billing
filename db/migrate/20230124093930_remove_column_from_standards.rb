# frozen_string_literal: true

class RemoveColumnFromStandards < ActiveRecord::Migration[7.0]
  def change
    remove_column :standards, :registered_users
  end
end
