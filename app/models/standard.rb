# frozen_string_literal: true

class Standard < ApplicationRecord
  belongs_to :client
  validates_presence_of :standard_type, :standard_rate, :client_id, :active_users,:month,:year
  validates :standard_type, inclusion: { in: ['Telematics', 'Accounting', 'Bin Module', 'Bin Monitoring', 'SMS Delivery', 'Routing'],
                                         message: "%{value} in not valid" }

  validate :date_is_before_current_date
  def date_is_before_current_date
    return unless "%{month},%{year}".to_date > DateTime.now

    errors.add("Date",'cannot be after current date')
  end
end
