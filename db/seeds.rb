# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

p 'Destroying Listings'
Listing.destroy_all
p 'Destroying Users'
User.destroy_all
p 'Destroying Bookings'
Booking.destroy_all

p 'Creating Users & Flats'
10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 10, max_length: 20),
    img_url: 'https://source.unsplash.com/random'
  )
  listing = Listing.new(
    name: Faker::Restaurant.name,
    address: Faker::Address.full_address,
    description: Faker::Restaurant.description,
    price: Faker::Number.within(range: 50..300),
    img_url: 'https://source.unsplash.com/random'
  )
  listing.owner = user
  listing.save!
end

p 'Creating Bookings'
10.times do
  booking = Booking.new(
    total: rand(10_000..20_000)
  )
  booking.listing = Listing.all.sample
  booking.user = User.all.sample
  booking.save!
end
