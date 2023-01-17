require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:user_type) }
    it { should validate_presence_of(:user_rate) }
    it { should validate_presence_of(:client_id) }
    it { should validate_presence_of(:active_users) }
    it { should_not allow_value("any").for(:user_type) }
    array = ["Admin","Dispacher","Mechanic", "Office Staff", "Sub Contractor","Technician","Consumers"]
    array.each do |value|
        it { should allow_value(value).for(:user_type) }
    end

  end
end