# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :client
  validates_presence_of :user_type, :user_rate, :client_id, :active_users, :registered_users,:month,:year
  validates :user_type, inclusion: { in: ['Admin', 'Dispacher', 'Mechanic', 'Office Staff', 'Sub Contractor', 'Technician', 'Consumers'],
                                     message: "%{value} in not valid" }
  validate :date_is_before_current_date
  validate :active_users_less_than_registered
  def date_is_before_current_date
    return true unless ("%{month},%{year}").to_date > DateTime.now

    errors.add("Date", 'cannot be after current date')
  end

  def active_users_less_than_registered
    if active_users
    return unless active_users > registered_users

    errors.add(:active_users, 'cannot be greater than registered users')
    end
  end
end
