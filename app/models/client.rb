# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :users
  has_many :standards
  has_many :bills
  validates_presence_of :company_name
  validates_presence_of :name, :company_name, :email, :address
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  def calculate_user_bill(client, m, y)
    total = 0
    client.users.where(month: m, year: y).find_each do |user|
      total += user.user_rate * user.active_users
    end
    total.round(2)
  end

  def calculate_standard_bill(client, m, y)
    total = 0
    client.standards.where(month: m, year: y).find_each do |standard|
      total += standard.standard_rate * standard.active_users
    end
    total.round(2)
  end

  def calculate_subtotal(user, standard)
    (user + standard).round(2)
  end

  def calculate_tax(subtotal)
    (subtotal * 13 / 100).round(2)
  end

  def calculate_total(subtotal, tax)
    (subtotal + tax).round(2)
  end
end
