class Client < ApplicationRecord
    has_many :users
    has_many :standards
    validates_presence_of :name,:company_name,:email
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, length: { maximum:255}, format: { with: VALID_EMAIL_REGEX } , uniqueness: true
end
