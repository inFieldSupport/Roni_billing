require 'rails_helper'

RSpec.describe "Bills", type: :request do
  describe "bills controller" do
    it "GET /show" do 
      employee = Employee.new(name:"Roni",email:"exampl@gmail.com",password:"password",password_confirmation:"password")
      employee.save
      client = Client.new(name:"Roni",company_name:"Any",email:"example@gmail.com",address:"Any")
      client.save
      bill = Bill.create(client_id:client.id,employee_id:employee.id)
      
      get bill_path(bill)
    end
    it "POST /create" do 
      @employee = Employee.new(name:"Roni",email:"exampl@gmail.com",password:"password",password_confirmation:"password")
      @employee.save
      @client = Client.new(name:"Roni",company_name:"Any",email:"example@gmail.com",address:"Any")
      @client.save
     
      post bills_path,:params => {  :client_id => @client.id,:employee_id => @employee.id } 
      get bill_path(Bill.first)
    end
    it "POST send-bill-mailer" do 
      employee = Employee.new(name:"Roni",email:"exampl@gmail.com",password:"password",password_confirmation:"password")
      employee.save
      client = Client.new(name:"Roni",company_name:"Any",email:"example@gmail.com",address:"Any")
      client.save
      bill = Bill.create(client_id:client.id,employee_id:employee.id)
      post send_bill_mail_path,:params => {  :id => bill.id } 
      
    end
    
  end
end
