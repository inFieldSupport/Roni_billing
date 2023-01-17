require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value('email@addresse.foo').for(:email) }
    it { should_not allow_value('email@addresse').for(:email) }
    it { should_not allow_value('email.foo').for(:email) }
    it { should_not allow_value('email').for(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:email).is_at_most(255) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end
end