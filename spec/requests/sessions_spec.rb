require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "contoller" do

    it " new,create session after creating logout" do 
      get root_path
      employee = Employee.new(name:"Roni",email:"example@gmail.com",password:"password",password_confirmation:"password")
      employee.save
      post signin_path,:params => { :session => { :email => employee.email,:password=>employee.password }} 
      delete logout_path
    end
    it " invalid signin" do 
        get root_path
        employee = Employee.new(name:"Roni",email:"example@gmail.com",password:"password",password_confirmation:"password")
       
        post signin_path,:params => { :session => { :email => employee.email,:password=>employee.password }} 
        get signin_path
      end
    
   end
end