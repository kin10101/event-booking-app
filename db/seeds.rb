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



# Clear existing data
Registration.destroy_all
Event.destroy_all
User.destroy_all


User.create!(
  name: "Admin User",
  email_address: "admin@example.com",
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


# Create users
users = [
  User.create!(name: "Alice Reyes", email_address: "alice@example.com", password: "password"),
  User.create!(name: "Bob Santos", email_address: "bob@example.com", password: "password"),
  User.create!(name: "Charlie Lim", email_address: "charlie@example.com", password: "password", admin: true)
]

# Create events
events = [
  Event.create!(
    name: "Ruby on Rails Workshop",
    date: Date.today + 7.days,
    location: "Manila",
    description: "An introductory workshop on Ruby on Rails for beginners.",
    user: users[0],
    closed: false
  ),
  Event.create!(
    name: "AI & Machine Learning Conference",
    date: Date.today + 14.days,
    location: "Cebu City",
    description: "A conference featuring talks and workshops on AI and machine learning.",
    user: users[1],
    closed: false
  ),
  Event.create!(
    name: "Weekend Hackathon",
    date: Date.today + 30.days,
    location: "Davao City",
    description: "A 48-hour coding competition for developers of all skill levels.",
    user: users[2],
    closed: false
  ),
  Event.create!(
    name: "Startup Pitch Night",
    date: Date.today + 21.days,
    location: "Quezon City",
    description: "Local startups present their ideas to investors and mentors.",
    user: users[0],
    closed: false
  )
]

# Create registrations
registrations = [
  { attendee_name: "John Doe", attendee_email: "john.doe@example.com", event: events[0] },
  { attendee_name: "Jane Smith", attendee_email: "jane.smith@example.com", event: events[0] },
  { attendee_name: "Mark Spencer", attendee_email: "mark.spencer@example.com", event: events[1] },
  { attendee_name: "Lucy Liu", attendee_email: "lucy.liu@example.com", event: events[2] },
  { attendee_name: "David Tan", attendee_email: "david.tan@example.com", event: events[3] }
]

registrations.each do |reg|
  Registration.create!(reg)
end

puts "Seeded #{User.count} users, #{Event.count} events, and #{Registration.count} registrations."