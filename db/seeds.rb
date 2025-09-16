# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# db/seeds.rb

# Create an admin
User.create!(
    name: "Admin User",
    email_address: "admin@gmail.com",
    password: "asdf",
    password_confirmation: "asdf",
    admin: true
  )
  
  # Create a normal user
  User.create!(
    name: "Test User",
    email_address: "user@example.com",
    password: "asdf",
    password_confirmation: "asdf"
  )
  