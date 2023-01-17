require 'rails_helper'

RSpec.describe Standard, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:standard_type) }
    it { should validate_presence_of(:standard_rate) }
    it { should validate_presence_of(:client_id) }
    it { should validate_presence_of(:active_users) }
    it { should_not allow_value("any").for(:standard_type) }
    array = ["Telematics","Accounting","Bin Module", "Bin Monitoring", "SMS Delivery","Routing"]
    array.each do |value|
        it { should allow_value(value).for(:standard_type) }
    end

  end
end