# frozen_string_literal: true

class Bill < ApplicationRecord
  belongs_to :employee
  belongs_to :client
  validates_presence_of :month,:year
  validate :date_is_before_current_date
  def date_is_before_current_date
    return unless "%{month},%{year}".to_date > DateTime.now

    errors.add("Date",'cannot be after current date')
  end
end
