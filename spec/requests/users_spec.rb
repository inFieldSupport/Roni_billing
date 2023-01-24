require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "user controller" do
    it "PUT" do
      employee = Employee.new(name:"Roni",email:"example@gmail.com",password:"password",password_confirmation:"password")
        employee.save
        client = Client.new(name:"Roni",company_name:"Any",email:"example@gmail.com",address:"Any")
        client.save
        user = User.new(client_id:client.id,user_rate:32,user_type:"Admin",active_users:32)
        user.save
      patch user_path(user),:params => {:user => { :user_rate => 43,:active_users=>10 }}
      end
  end
end
