require 'faker'
require 'colorize'
require 'open-uri'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create new thread for Chuck Norris jokes while seeding db
thr = Thread.new do
  puts "Creating 5k records with various associations.".black.on_white
  puts "May take a short bit but did you know...".black.on_white
  while true
    puts ""
    puts JSON.load(open("https://api.chucknorris.io/jokes/random?category=dev"))['value'].light_cyan.on_black
    sleep(5)
  end
end

# Create 1 customer
customer = Customer.create(name: "Soul Cycle")

# Create 50 customer locations
n_locations = 50
n_locations.times do
  customer.locations.create(name: Faker::Address.community, latitude: Faker::Address.latitude, longitude: Faker::Address.longitude)
end

# Create 20 random vendors
n_vendors = 20
n_vendors.times do
  Vendor.create(name: Faker::Company.name)
end

# Create 10k orders with random vendor/customer associations
# and random delivered statuses and lengths
5000.times do
  customer.orders.create(location_id: rand(1..n_locations), vendor_id: rand(1..n_vendors), tracking: Faker::Number.number(15), delivered: [true, false].sample, shipment_duration: rand(1.0..15.0).round(2))
end

thr.terminate
