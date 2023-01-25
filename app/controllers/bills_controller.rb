# frozen_string_literal: true

class BillsController < ApplicationController
  def show
    @bill = Bill.find(params[:id])
    @client = @bill.client
    @employee = @bill.employee
  end

  def create
    @bill = Bill.new(client_id: params[:client_id], employee_id: params[:employee_id], year: params[:year],
                     month: params[:month])
    if @bill.save
      flash[:success] = 'Bill created successfully'
      redirect_to @bill
    else
      flash.now[:danger] = @bill.errors.full_messages[0]
      render 'clients/show'
    end
  end

  def send_bill_mail
    @bill = Bill.find(params[:id])


    BillMailer.client_bill(@bill).deliver_now
    flash[:success] = 'Mail sent successfully'
    redirect_to @bill.client
  end

  private

  def bill_params
    params.require(:bill).permit(:client_id, :employee_id, :year, :month)
  end
end
