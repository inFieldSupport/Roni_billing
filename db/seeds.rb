

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'
CSV.foreach(Rails.root.join('lib/csv/clients.csv'), headers: true) do |row|
  
  Client.create({
    company_name: row[0]
  })
end
CSV.foreach(Rails.root.join('lib/csv/user.csv'), headers: true) do |row|
  
 client= Client.find_by(company_name:row[3])
 client.users.create(
    user_type: row[0],
    user_rate: row[1],
    active_users: row[2]
 )

end
CSV.foreach(Rails.root.join('lib/csv/standard.csv'), headers: true) do |row|
  
    client= Client.find_by(company_name:row[3])
    client.standards.create(
       standard_type: row[0],
       standard_rate: row[1],
       active_users: row[2]
    )
   
   end

