class BillsController < ApplicationController

    def show
        @bill = Bill.find(params[:id])
        @client = @bill.client
        @employee = @bill.employee
    end
    def create
        @bill = Bill.new(client_id:params[:client_id],employee_id:params[:employee_id])
        if @bill.save
            
            redirect_to @bill
        else
            render 'clients/show'
        end
    end
    def send_bill_mail
        @bill = Bill.find(params[:id])
        
      
        BillMailer.client_bill(@bill).deliver_now
      
        redirect_to @bill.client
      end
    private
        def bill_params
            params.require(:bill).permit(:client_id,:employee_id)
        end
end
