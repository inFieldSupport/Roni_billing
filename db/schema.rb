# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_124_094_359) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'bills', force: :cascade do |t|
    t.bigint 'employee_id', null: false
    t.bigint 'client_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'month'
    t.integer 'year'
    t.index ['client_id'], name: 'index_bills_on_client_id'
    t.index ['employee_id'], name: 'index_bills_on_employee_id'
  end

  create_table 'clients', force: :cascade do |t|
    t.string 'name'
    t.string 'company_name'
    t.string 'address'
    t.string 'email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'employees', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'standards', force: :cascade do |t|
    t.string 'standard_type'
    t.float 'standard_rate'
    t.integer 'active_users'
    t.bigint 'client_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'month'
    t.integer 'year'
    t.index ['client_id'], name: 'index_standards_on_client_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'user_type'
    t.float 'user_rate'
    t.integer 'active_users'
    t.integer 'registered_users'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'client_id', null: false
    t.string 'month'
    t.integer 'year'
    t.index ['client_id'], name: 'index_users_on_client_id'
  end

  add_foreign_key 'bills', 'clients'
  add_foreign_key 'bills', 'employees'
  add_foreign_key 'standards', 'clients'
  add_foreign_key 'users', 'clients'
end
