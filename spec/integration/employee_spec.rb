require 'rails_helper'

RSpec.describe "Employees", type: :request do
 context "integration testing for employee" do
  it "first a employee need to sign in,then go to index page and clients page" do
    employee = Employee.create(name:"Any",email:"example@gmail.com",password:"foobar")
  get root_path
  post signin_path,:params => { :session => { :email => employee.email,:password=>employee.password }} 
  get employees_path
 
  get clients_path 
  get logout_path
  end
 end
 
end