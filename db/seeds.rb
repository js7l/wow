# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"

puts "Destroying all users"
User.destroy_all

puts "Creating users"
file = File.open(Rails.root.join("app/assets/images/ratna.png"))
ratna = User.new(first_name: "Ratna", last_name: "Purwati", email: "ratna@gmail.com", password: "123123")
ratna.avatar.attach(io: file, filename: 'nes.png', content_type: 'image/png')
ratna.save!

file = File.open(Rails.root.join("app/assets/images/nina.jpg"))
nina = User.new(first_name: "Christina", last_name: "Sugiono", email: "christina@gmail.com", password: "123123")
nina.avatar.attach(io: file, filename: 'nes.png', content_type: 'image/png')
nina.save!

file = File.open(Rails.root.join("app/assets/images/jess.jpg"))
jess = User.new(first_name: "Jess", last_name: "Wong", email: "jess@gmail.com", password: "123123")
jess.avatar.attach(io: file, filename: 'nes.png', content_type: 'image/png')
jess.save!

file = File.open(Rails.root.join("app/assets/images/daniel.jpg"))
daniel = User.new(first_name: "Daniel", last_name: "Rodriguez", email: "daniel@gmail.com", password: "123123")
daniel.avatar.attach(io: file, filename: 'nes.png', content_type: 'image/png')
daniel.save!

file = File.open(Rails.root.join("app/assets/images/ray.jpg"))
ray = User.new(first_name: "Ray", last_name: "Han", email: "rayhan@gmail.com", password: "123123")
ray.avatar.attach(io: file, filename: 'nes.png', content_type: 'image/png')
ray.save!
puts "#{User.count} users created"

puts "Creating studios"
canggu_studio = Studio.new({ name: 'The Canggu Studio', address: 'Canggu, Kec. Kuta Utara, Bali', email: 'info@thecanggustudio.com', phone_number: '+62 823 39770272', description: 'The Canggu Studio is your workout home away from home situated in the heart of Canggu. Here you can be yourself, without holding back.' })
file = URI.open("https://thecanggustudio.com/wp-content/uploads/2020/08/Logo_TheCangguStudio.png")
canggu_studio.avatar.attach(io: file, filename: "whatever.jpg")
canggu_studio.save!

samadi_studio = Studio.new({ name: 'Samadi', address: 'Jalan Padang Linjong 39, Echo Beach Canggu Bali', email: 'contact@samadibali.com', phone_number: '+62 (0)81238312505', description: 'To be at your service with Love and Care Samadi brings in the best of national and international Teachers, Therapists, Facilitators, Chefs, Artists and Experts who have trained themselves extensively in a variety of different Programs, Practices and Skills. All so our Team at Samadi bring a wealth of wisdom and experience with the eagerness to share their love and passion with you.' })
file = URI.open("https://www.samadibali.com/wp-content/uploads/2021/01/samadi-logo.png")
samadi_studio.avatar.attach(io: file, filename: "samadi.jpg")
samadi_studio.save!

practice_studio = Studio.new({ name: 'The practice', address: 'Jalan Batu Bolong #94A, Canggu, Bali', email: 'reception@thepracticebali.com', phone_number: '+62 361 300 3446', description: 'The Practice is a leading institution in lineage-based Traditional Hatha education. Evolve your practice. Evolve your life.' })
file = URI.open("https://i1.sndcdn.com/avatars-000214568754-pltff5-t500x500.jpg")
practice_studio.avatar.attach(io: file, filename: "practice.jpg")
practice_studio.save!
puts "#{Studio.count} studios created"
