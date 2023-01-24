require 'rails_helper'

RSpec.describe "Standards", type: :request do
  describe "standard controller" do
    it "PUT" do
    employee = Employee.new(name:"Roni",email:"example@gmail.com",password:"password",password_confirmation:"password")
      employee.save
      client = Client.new(name:"Roni",company_name:"Any",email:"example@gmail.com",address:"Any")
      client.save
      standard = Standard.new(client_id:client.id,standard_rate:32,standard_type:"Telematics",active_users:32)
      standard.save
    patch standard_path(standard),:params => {:standard => { :standard_rate => 43,:active_users=>10 }}
    end
  end
end
