class Standard < ApplicationRecord
  belongs_to :client
  validates_presence_of :standard_type,:standard_rate,:client_id,:active_users
  validates :standard_type , inclusion: { in: ["Telematics","Accounting","Bin Module", "Bin Monitoring", "SMS Delivery","Routing"], 
                                      message: "%{value} in not valid" }
end
