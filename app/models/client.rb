class Client < ApplicationRecord
    has_many :users
    has_many :standards
    validates_presence_of :company_name
    validates_presence_of :name,:company_name,:email,:address
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, length: { maximum:255}, format: { with: VALID_EMAIL_REGEX } , uniqueness: true
    def calculate_user_bill(client)
        total = 0
        client.users.each do |user|
            total = total + (user.user_rate)*(user.active_users)
        end
        return total.round(2)

    end
    def calculate_standard_bill(client)
        total = 0
        client.standards.each do |standard|
            total = total + (standard.standard_rate)*(standard.active_users)
        end
        return total.round(2)

    end
    def calculate_subtotal(user,standard)
        return (user + standard).round(2)
    end
    def calculate_tax(subtotal)
        return (subtotal*13/100).round(2)
    end
    def calculate_total(subtotal,tax)
        return (subtotal + tax).round(2)
    end

end
