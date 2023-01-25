# frozen_string_literal: true

class BillMailer < ApplicationMailer
  def client_bill(bill)
    @bill = bill
    mail(to: @bill.client.email, subject: 'Invoice')
  end
end
