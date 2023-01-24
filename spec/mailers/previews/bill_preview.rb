# Preview all emails at http://localhost:3000/rails/mailers/bill
class BillPreview < ActionMailer::Preview
    def bill
        @bill= Bill.first
        BillMailer.client_bill(@bill)
      end
end
