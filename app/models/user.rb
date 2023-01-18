class User < ApplicationRecord
    belongs_to :client
    validates_presence_of :user_type,:user_rate,:client_id,:active_users
    validates :user_type , inclusion: { in: ["Admin","Dispacher","Mechanic", "Office Staff", "Sub Contractor","Technician","Consumers"], 
                                        message: "%{value} in not valid" }
  
end
