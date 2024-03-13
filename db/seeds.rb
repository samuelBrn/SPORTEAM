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

# Assurez-vous de vider la base de données avant de la remplir pour éviter les doublons
# Commentez ces lignes si vous souhaitez garder les données existantes

require 'open-uri'

Favourite.delete_all
Participation.delete_all
Event.delete_all
Category.delete_all
User.delete_all

puts " Suppression des données existantes..."
puts " Création de nouvelles données..."

# # Création de quelques catégories de sport
football_cat = Category.create(sport: 'Football')
yoga_cat = Category.create(sport: 'Yoga')
basket_cat = Category.create(sport: 'Basketball')

# # Création de quelques utilisateurs
10.times do |index|
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password', # Assurez-vous que votre modèle User utilise has_secure_password ou Devise
    phone_number: Faker::PhoneNumber.phone_number,
    age: rand(25..40)
  )

  # puts asset_path('user_1.png')
  image_path = Rails.root.join("app", "assets", "images", "user_#{index + 1 }.png")
  user.avatar.attach(io: File.open(image_path), filename: "user_#{index + 1}.png", content_type: "image/png")
end


current_user = User.create!(
  first_name: "dad",
  last_name: "toc",
  email: "test@test.com",
  password: 'password', # Assurez-vous que votre modèle User utilise has_secure_password ou Devise
  phone_number: Faker::PhoneNumber.phone_number,
  age: rand(25..40),
)
image_path = Rails.root.join("app", "assets", "images", "user_1.png")
current_user.avatar.attach(io: File.open(image_path), filename: "user_1.png", content_type: "image/png")

puts " Création d'event basketball..."

description_basketball = [
  "For fun, everyone's welcome to join in the game!",
  "Get ready to hit the pavement and show off your skills in our streetball tournamenty.",
  "Score some hoops and sizzle some burgers at our basketball BBQ bashm ",
  "JOIN US FOR GOOD TIME 😀"
]

adresses_paris_basketball = [
  "22 Rue Duperré, 75009 Paris",
  "10 Rue Pierre Nicole, 75005 Paris",
  "60 Rue François 1er, 75008 Paris",
  "142 Quai de Jemmapes, 75010 Paris",
]
terrain_name_basketball = [
  "Terrain de basket du square Claude Bernard",
  "Terrain Stalingrad",
  "Terrain Léo Lagrange",
  "Terrain de sport des jardins Saint-Paul",
]
start_date_range = DateTime.new(2024, 3, 20)..DateTime.new(2024, 4, 10)
end_date_range = DateTime.new(2024, 3, 20, 8, 0, 0)..DateTime.new(2024, 4, 10, 20, 0, 0)


adresses_paris_basketball.each_with_index do |adresse, index|
  event_basketball = Event.create!(
      user: User.all.sample,
      category_id: basket_cat.id,
      name: terrain_name_basketball[index],
      adress: adresse,
      start_at: Faker::Time.between(from: start_date_range.begin, to: start_date_range.end, format: :default),
      end_at: Faker::Time.between(from: end_date_range.begin, to: end_date_range.end, format: :default),
      status: ["planned", "ongoing", "completed"].sample,
      max_player: rand(5..20),
      min_player: rand(2..5),
      description: description_basketball[index]
    )

  image_path = Rails.root.join("app", "assets", "images", "event_#{index + 1}.png")
  event_basketball.image.attach(io: File.open(image_path), filename: "event_#{index + 1}.png", content_type: "image/png")

end

puts " Création d'event football..."

description_football = [
  "Calling all football fanatics! Lace up your cleats and join us for some pigskin action on the field.",
  "all levels welcome, let's have fun",
  "Tis event is all about friendly competition, good vibes, and delicious treats on the sidelines.",
  "LET'S PLAY FOOTBALL COMPETITION 100% !"
]

adresses_paris_football = [
  "68 Bd Poniatowski, 75012 Paris",
  "2 Av. de Suffren, 75007 Paris",
  "Université Paris VI, 75005 Paris",
  "9 Rue Charlemagne, 75013 Paris"
]
terrain_name_football = [
  "Terrain de Sport de la Grange aux Belles",
  "Stade Emile Anthoine",
  "Terrain de Football du Square Léon",
  "LE FIVE"
]

adresses_paris_football.each_with_index do |adresse, index|
  event_football = Event.create!(
      user: User.all.sample,
      category_id: football_cat.id,
      name: terrain_name_football[index],
      adress: adresse,
      start_at: Faker::Time.between(from: start_date_range.begin, to: start_date_range.end, format: :default),
      end_at: Faker::Time.between(from: end_date_range.begin, to: end_date_range.end, format: :default),
      status: ["planned", "ongoing", "completed"].sample,
      max_player: rand(5..20),
      min_player: rand(2..5),
      description: description_football[index]

    )
  image_path = Rails.root.join("app", "assets", "images", "event_foot_#{index + 1}.png")
  event_football.image.attach(io: File.open(image_path), filename: "event_foot_#{index + 1}.png", content_type: "image/png")

end

puts " Création d'event yoga..."

description_yoga = [
  "Hey yogis! Let's stretch, laugh, and relax together in the park.",
  "No experience necessary, just bring your mat and good vibes!",
  "start your day with a little zen and a lot of fun come",
  "morning yoga,  laughter and relaxation. No judgment, good vibes and positive energy!"

]

adresses_paris_yoga = [
  "68 Rue Jean-Jacques Rousseau, 75001 Paris",
  "90 Bd Richard-Lenoir, 75011 Paris",
  "4 Cité Griset, 75011 Paris",
  "31 Rue Bonaparte, 75006 Paris"
]
terrain_name_yoga = [
  "YUJ YOGA STUDIO ",
  "WeYog",
  "Rêve yogain",
  "France Yoga",
]

adresses_paris_yoga.each_with_index do |adresse, index|
  event_yoga = Event.create!(
      user: User.all.sample,
      category_id: yoga_cat.id,
      name: terrain_name_yoga[index],
      adress: adresse,
      start_at: Faker::Time.between(from: start_date_range.begin, to: start_date_range.end, format: :default),
      end_at: Faker::Time.between(from: end_date_range.begin, to: end_date_range.end, format: :default),
      status: ["planned", "ongoing", "completed"].sample,
      max_player: rand(5..20),
      min_player: rand(2..5),
      description: description_yoga[index],
    )
  image_path = Rails.root.join("app", "assets", "images", "event_yoga_#{index + 1}.png")
  event_yoga.image.attach(io: File.open(image_path), filename: "event_yoga_#{index + 1}.png", content_type: "image/png")

end


# Création de participations aléatoires pour lier les utilisateurs aux événements
User.all.each do |user|
  user.participations.create(
    event_id: Event.all.sample.id,
    has_participated: [true, false].sample
  )
end

# Création de favoris aléatoires pour lier les utilisateurs aux catégories de sport
other_user = User.where.not(first_name: "dad")
other_user.each do |user|
  user.favourites.create(
    category_id: Category.all.sample.id # Corrigé ici
  )
end

Category.all.each do |category|
  current_user.favourites.create(
    category_id: category.id
  )
end

Event.all.each do |e|
  Participation.create(
    user: User.last, event: e
  )
end

puts 'Nouvelles données créées avec succès !'
