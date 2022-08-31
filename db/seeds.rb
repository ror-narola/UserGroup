# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
## Create sample users
(1..100).each do |i|
  user = User.new(first_name: "User", last_name: "#{i}", email: "user#{i}@example.com", password: "password", password_confirmation: "password")
  user.save
end
