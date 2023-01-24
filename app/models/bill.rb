class Bill < ApplicationRecord
  belongs_to :employee
  belongs_to :client
  # validates :client_id, uniqueness: true
end
