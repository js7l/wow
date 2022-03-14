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
puts "Destroying all studios"
Studio.destroy_all
puts "Destroying all sessions"
Event.destroy_all
puts "Destroying chatroom"
Chatroom.destroy_all

puts "Creating users"
file = File.open(Rails.root.join("app/assets/images/ratna.png"))
ratna = User.new(first_name: "Ratna", last_name: "Purwati", email: "ratna@gmail.com", password: "123123")
ratna.avatar.attach(io: file, filename: 'nes.png', content_type: 'image/png')
ratna.save!

file = File.open(Rails.root.join("app/assets/images/nina.png"))
nina = User.new(first_name: "Christina", last_name: "Sugiono", email: "christina@gmail.com", password: "123123")
nina.avatar.attach(io: file, filename: 'nes.png', content_type: 'image/png')
nina.save!

file = File.open(Rails.root.join("app/assets/images/jess.png"))
jess = User.new(first_name: "Jess", last_name: "Wong", email: "jess@gmail.com", password: "123123")
jess.avatar.attach(io: file, filename: 'nes.png', content_type: 'image/png')
jess.save!

file = File.open(Rails.root.join("app/assets/images/daniel.png"))
daniel = User.new(first_name: "Daniel", last_name: "Rodriguez", email: "daniel@gmail.com", password: "123123")
daniel.avatar.attach(io: file, filename: 'nes.png', content_type: 'image/png')
daniel.save!

file = File.open(Rails.root.join("app/assets/images/ray.png"))
ray = User.new(first_name: "Ray", last_name: "Han", email: "rayhan@gmail.com", password: "123123")
ray.avatar.attach(io: file, filename: 'nes.png', content_type: 'image/png')
ray.save!

file = File.open(Rails.root.join("app/assets/images/joana.jpeg"))
joana = User.new(first_name: "Joana", last_name: "nana", email: "joana@gmail.com", password: "123123")
joana.avatar.attach(io: file, filename: 'nes.png', content_type: 'image/png')
joana.save!
puts "#{User.count} users created"

puts "Creating studios"
canggu = Studio.new({ name: 'The Canggu Studio', address: 'Batu Bolong, Bali', email: 'info@thecanggustudio.com', phone_number: '+62 823 39770272', user: nina,
  description: 'The Canggu Studio is your workout home away from home situated in the heart of Canggu. Here you can be yourself, without holding back.' })
file = File.open(Rails.root.join("app/assets/images/logo-thecanggustudio.png"))
canggu.avatar.attach(io: file, filename: "canggu.jpg")
canggu.save!

samadi = Studio.new({ name: 'Samadi', address: 'Echo Beach Canggu, Bali', email: 'contact@samadibali.com', phone_number: '+62 (0)81238312505', user: ratna,
  description: 'To be at your service with Love and Care Samadi brings in the best of national and international Teachers, Therapists, Facilitators, Chefs, Artists and Experts who have trained themselves extensively in a variety of different Programs, Practices and Skills. All so our Team at Samadi bring a wealth of wisdom and experience with the eagerness to share their love and passion with you.' })
file = File.open(Rails.root.join("app/assets/images/samadi.png"))
samadi.avatar.attach(io: file, filename: "samadi.jpg")
samadi.save!

bodyfactory = Studio.new({ name: 'Body Factory Bali', address: 'Berawa, Bali', email: 'info@bodyfactorybali.com', phone_number: '+ 62 811 3802 255', user: jess,
  description: 'A comprehensive approach to gym Bali. Body Factory Bali is an intelligent fitness, health, and wellness facility expertly delivered in our luxurious tropical location in Canggu. Experience working out in one of the best, all-inclusive approach to fitness and a healthy lifestyle. Located inside the building that housed an old silver factory, Body Factory Bali is so much more than a gym.' })
file = File.open(Rails.root.join("app/assets/images/bodyfactory.png"))
bodyfactory.avatar.attach(io: file, filename: "bodyfactory.jpg")
bodyfactory.save!

wanderlust = Studio.new({ name: 'Wanderlust Fitness', address: 'Canggu, Bali', email: 'info@wanderlustfitnessvillage.com', phone_number: '+62 (0) 878 6156 8934', user: ray,
  description: "Bali's premier training facility!" })
file = File.open(Rails.root.join("app/assets/images/logo-wanderlust.png"))
wanderlust.avatar.attach(io: file, filename: "wanderlust.jpg")
wanderlust.save!

matra = Studio.new({ name: 'Matra Bali', address: 'Kuta, Bali', email: 'info@matrabali.com', phone_number: '+62 819 9909 5888', user: daniel,
  description: 'Matra Bali has everything you need to make your stay relaxing, reviving and memorable. Allow us to welcome you into our family and show you the magic of our beautiful island. We can’t wait to meet you!' })
file = File.open(Rails.root.join("app/assets/images/logo-green.png"))
matra.avatar.attach(io: file, filename: "matra.jpg")
matra.save!

padang = Studio.new({ name: 'Padang Padang Surf Camp', address: 'Pecatu, Bali', email: 'info@padangsurf.com', phone_number: '+62 821 4781 2880', user: joana,
  description: "Our camp — located in Padang Padang on Bali's Bukit Peninsular — is arguably the pick of the spots in the world's premier surfing destination." })
file = File.open(Rails.root.join("app/assets/images/padang.png"))
padang.avatar.attach(io: file, filename: "padang.jpg")
padang.save!
puts "#{Studio.count} studios created"

puts "Creating events"
power_yoga = Event.new(name: "Power Yoga", category: "Yoga", date: Date.today + 1.day, time: Time.parse('15:00'), duration: 60, description: "Power Yoga is a strength-focused dynamic Vinyasa practice. An offshoot of Ashtanga Yoga, it has many of the same qualities and benefits, including building internal heat, increasing stamina, strength, and flexibility. With a focus on core and shoulder strength, we will slowly build up towards more advanced poses, arm balances, and inversions.",
  price: 165000, instructor: "Rara", studio: canggu, limit_attendees: 12, level: "Intermediate")
file = File.open(Rails.root.join("app/assets/images/yoga-canggustudio.jpg"))
power_yoga.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
power_yoga.save!

bootyfit = Event.new(name: "Bootyfit", category: "HIIT", date: Date.today + 1.day, time: Time.parse('15:00'), duration: 60, description: "Targeting abs, thighs and booty, but a full body workout, be prepared to sweat in this intense workout. We will go through different series of exercises each time, using different equipment to challenge your stamina, balance and to get that booty into shape!",
  price: 165000, instructor: "Christina", studio: canggu, limit_attendees: 12, level: "All Levels")
file = File.open(Rails.root.join("app/assets/images/bootyfit-canggustudio.jpg"))
bootyfit.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
bootyfit.save!

boxing = Event.new(name: "Boxing", category: "Boxing", date: Date.today + 2.day, time: Time.parse('16:00'), duration: 60, description: "A high intensity, high cardio class with a focus on English boxing technique.",
  price: 165000, instructor: "Danny", studio: wanderlust, limit_attendees: 10, level: "All Levels")
file = File.open(Rails.root.join("app/assets/images/boxing-wanderlust.jpg"))
boxing.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
boxing.save!

pilates = Event.new(name: "Pilates", category: "Others", date: Date.today + 2.day, time: Time.parse('16:00'), duration: 75, description: "Pilates advocates tout the core-strengthening benefits of the method to improve posture and balance. Pilates targets the “powerhouse” muscles, which include the glutes, hips, pelvic floor, and lower back. Similar to yoga, the Pilates Method encourages deep, conscious breathing. Pilates is widely used in rehabilitation settings but is also beneficial to fitness advocates and elite athletes alike.",
  price: 150000, instructor: "Jojo", studio: samadi, limit_attendees: 15, level: "All Levels")
file = File.open(Rails.root.join("app/assets/images/pilates.png"))
pilates.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
pilates.save!

flyhigh = Event.new(name: "Fly High Yoga", category: "Yoga", date: Date.today + 2.day, time: Time.parse('15:30'), duration: 75, description: "A form of therapeutic aerial yoga which focuses on the lengthening the spine and creating space between the vertebrae. Relax the body into its natural form and curves allowing gravity do the work for you. In Fly High Yoga a student uses a belt securely attached to the ceiling to perform numerous sets of poses hanging from the belt.",
  price: 150000, instructor: "Melly", studio: samadi, limit_attendees: 15, level: "All Levels")
file = File.open(Rails.root.join("app/assets/images/samadiflyyoga.jpeg"))
flyhigh.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
flyhigh.save!

yoga_for_surfers = Event.new(name: "Yoga For Surfers", category: "Yoga", date: Date.today + 1.day, time: Time.parse('16:00'), duration: 75, description: "Whether you’re an expert surfer or just getting your feet wet in the surf, yoga is one of the best ways to keep your body loose and agile for the waves. This Yoga For Surfers sequence will take you through 21 yoga poses that focus on lengthening and releasing pressure in the spine, stretching all those surfing muscles, and opening the chest, shoulders, and hips.",
  price: 150000, instructor: "Pooja", studio: samadi, limit_attendees: 15, level: "All Levels")
file = File.open(Rails.root.join("app/assets/images/yogasurf.jpeg"))
yoga_for_surfers.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
yoga_for_surfers.save!

surf1 = Event.new(name: "Surfing Level 1", category: "Surfing", date: Date.today + 2.day, time: Time.parse('21:00'), duration: 120, description: "It’s now time to jump in the water! During our 2-hour surf lesson, the surf instructor will be right next to you at all times. This way you will always feel safe. Staying in the right spot will guarantee maximum fun. You will also catch as many waves as possible, often from your very first lesson.",
  price: 165000, instructor: "Darren", studio: matra, limit_attendees: 15, level: "Beginner")
file = File.open(Rails.root.join("app/assets/images/surfing5.webp"))
surf1.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
surf1.save!

muaythai = Event.new(name: "Muay Thai", category: "Boxing", date: Date.today + 2.day, time: Time.parse('21:00'), duration: 90, description: "A 90-minute Muay Thai and kickboxing pad work class, each member gets 3+ rounds of pad work time with one of the trainers, followed by drills, bag work and conditioning.",
  price: 130000, instructor: "Rayhan", studio: bodyfactory, limit_attendees: 12, level: "Beginner")
file = File.open(Rails.root.join("app/assets/images/muaythai.jpeg"))
muaythai.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
muaythai.save!

weightlifting = Event.new(name: "Weight Lifting", category: "Weight-Lifting", date: Date.today + 1.day, time: Time.parse('15:00'), duration: 90, description: "Olympic Weightlifting is the sport of Strength, Power, Speed and Precision. In competition, the lifts are comprised of the Snatch and the Clean & Jerk – both of which are efforts to lift the maximum amount of weight from ground to overhead in two distinct ways. In training, weightlifting and accessory exercises challenge the mind and body to grow strong and powerful through repetition after repetition of the basics.",
  price: 130000, instructor: "Andrey", studio: bodyfactory, limit_attendees: 8, level: "All Levels")
file = File.open(Rails.root.join("app/assets/images/weightlifting.jpeg"))
weightlifting.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
weightlifting.save!

crossfit = Event.new(name: "Crossfit", category: "Crossfit", date: Date.today + 1.day, time: Time.parse('17:30'), duration: 75, description: "Whether you’re an expert surfer or just getting your feet wet in the surf, yoga is one of the best ways to keep your body loose and agile for the waves. This Yoga For Surfers sequence will take you through 21 yoga poses that focus on lengthening and releasing pressure in the spine, stretching all those surfing muscles, and opening the chest, shoulders, and hips.",
  price: 150000, instructor: "Ryan", studio: wanderlust, limit_attendees: 15, level: "All Levels")
file = File.open(Rails.root.join("app/assets/images/crossfit.jpg"))
crossfit.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
crossfit.save!

rockclimbing = Event.new(name: "Indoor Rock Climbing", category: "Others", date: Date.today + 1.day, time: Time.parse('17:30'), duration: 120, description: "Learn the basics of climbing and rope-handling. This includes tying a figure-eight knot, climbing commands, and belaying. This one-time, 2 hour introductory class will equip you with the necessary skills to belay a climber on top-rope.",
  price: 250000, instructor: "Sandi", studio: wanderlust, limit_attendees: 10, level: "Beginner")
file = File.open(Rails.root.join("app/assets/images/climbing1.jpg"))
rockclimbing.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
rockclimbing.save!

surf2 = Event.new(name: "Surfing Level 2", category: "Surfing", date: Date.today + 1.day, time: Time.parse('17:30'), duration: 120, description: "Level 2 surfers can comfortably stand on the board and are focusing on catching unbroken waves.  The surf lessons will focus on the point of paddling past the whitewater and starting to catch waves before they break. The student will learn how to paddle in different ways beginning to understand the negotiation of waves efficiently and safely 'out the back'.",
  price: 165000, instructor: "Agus", studio: matra, limit_attendees: 15, level: "Intermediate")
file = File.open(Rails.root.join("app/assets/images/surfing1.jpg"))
surf2.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
surf2.save!

surfb = Event.new(name: "Surfing K1", category: "Surfing", date: Date.today + 1.day, time: Time.parse('17:30'), duration: 120, description: "Our beginners surfing lessons are suitable for anyone who has; never surfed before, has very little experience with surfing or it’s been a long time since you last surfed.",
  price: 180000, instructor: "Christo", studio: padang, limit_attendees: 1, level: "Beginner")
file = File.open(Rails.root.join("app/assets/images/surfing2.webp"))
surfb.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
surfb.save!

surfi = Event.new(name: "Surfing K2", category: "Surfing", date: Date.today + 1.day, time: Time.parse('19:00'), duration: 120, description: "As an intermediate surfer, this wave gives you an opportunity to challenge yourself and to improve your surfing skills dramatically.",
  price: 180000, instructor: "Mike", studio: padang, limit_attendees: 1, level: "Intermediate")
file = File.open(Rails.root.join("app/assets/images/surfing3.webp"))
surfi.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
surfi.save!

surfa = Event.new(name: "Surfing K3", category: "Surfing", date: Date.today + 1.day, time: Time.parse('19:00'), duration: 120, description: "If you are an experienced surfer, someone that has been surfing consistently for several years and are comfortable in most surfing conditions with waves double-triple overhead in size, but you are not yet familiar with the characteristics of the surf spots in Bali, advanced surf guiding is the best option for you. With advanced surf guiding you will receive information about the surf breaks as well as eliminate unnecessary risk so you can enjoy your surfing maximally. You will also have the opportunity to surf some of the best waves in the World with expert surf guides.",
  price: 180000, instructor: "Blacky", studio: padang, limit_attendees: 1, level: "Advanced")
file = File.open(Rails.root.join("app/assets/images/surfing4.webp"))
surfa.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
surfa.save!
puts "#{Event.count} sessions created"

puts "Creating chatroom"
chatroom1 = Chatroom.new(user: ratna, studio: canggu)
chatroom1.save!

# message
message1 = Message.create!(content: "Hello", user: ratna, chatroom: chatroom1)
