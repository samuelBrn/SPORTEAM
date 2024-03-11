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
Category.create(sport: 'Football')
Category.create(sport: 'Yoga')
Category.create(sport: 'Basketball')


# # Création de quelques utilisateurs
10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password', # Assurez-vous que votre modèle User utilise has_secure_password ou Devise
    phone_number: Faker::PhoneNumber.phone_number,
    age: rand(25..40)
  )

  avatar_url = Faker::Avatar.image(slug: "my-own-slug", size: "50x50", format: "png")
  file = URI.open(avatar_url)
  user.avatar.attach(io: file, filename: "avatar_#{user.id}.png", content_type: "image/png")
end


adresses_paris = [
  "48 Rue de Rivoli, 75004 Paris",
  "10 Avenue des Champs-Élysées, 75008 Paris",
  "15 Rue de Vaugirard, 75006 Paris",
  "1 Avenue Montaigne, 75008 Paris",
  "55 Rue du Faubourg Saint-Antoine, 75011 Paris",
  "128 Rue La Boétie, 75008 Paris",
  "82 Rue de Maubeuge, 75009 Paris",
  "70 Rue de Belleville, 75020 Paris",
  "33 Avenue du Général Leclerc, 75014 Paris",
  "5 Rue de l'École de Médecine, 75006 Paris"
]

adresses_paris.each_with_index do |adresse, index|
  event = Event.create!(
    user: User.all.sample,
    category_id: Category.all.sample.id,
    name: Faker::Sports::Football.competition,
    adress: adresse,
    start_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default),
    end_at: Faker::Time.between(from: DateTime.now, to: DateTime.now + 1, format: :default),
    status: ["planned", "ongoing", "completed"].sample,
    max_player: rand(5..20),
    min_player: rand(2..5),
    description: Faker::Lorem.sentence(word_count: 10)
  )

  image_url = Faker::LoremFlickr.image(size: "300x300", search_terms: ['sport']) + "?random=#{index}"
  file = URI.open(image_url)
  event.image.attach(io: file, filename: "event_#{index + 1}.png", content_type: "image/png")
end


# Création de participations aléatoires pour lier les utilisateurs aux événements
User.all.each do |user|
  user.participations.create(
    event_id: Event.all.sample.id,
    has_participated: [true, false].sample
  )
end

# Création de favoris aléatoires pour lier les utilisateurs aux catégories de sport
User.all.each do |user|
  user.favourites.create(
    category_id: Category.all.sample.id # Corrigé ici
  )
end
Event.all.each do |e|
  Participation.create(
    user: User.last, event: e
  )
end

puts 'Nouvelles données créées avec succès !'
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

adresses_paris_basketball = [
  "9 rue Charlemagne, 75004 Paris",
  "68 boulevard poniatowski, 75012 Paris",
  "176 Boulevard Macdonald, 75019 Paris",
  "61 boulevard Vincent Auriol75013 Paris",
]
terrain_name = [
  "Terrain de basket du square Claude Bernard"
  "Terrain de basket-ball 3*3 Stalingrad"
  "Terrain de Basket-ball 3*3 Léo Lagrange"
  "Terrain de sport des jardins Saint-Paul"
]

adresses_paris_basketball.each_with_index do |adresse, index|
  terrain_name.each do |name|
    eventBasketball = Event.create!(
      user: User.all.sample,
      category_id: Category.all.sample.id,
      name: terrain_name.,
      adress: adresse,
      start_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default),
      end_at: Faker::Time.between(from: DateTime.now, to: DateTime.now + 1, format: :default),
      status: ["planned", "ongoing", "completed"].sample,
      max_player: rand(5..20),
      min_player: rand(2..5),
      description: Faker::Lorem.sentence(word_count: 10)
    )

  image_url = Faker::LoremFlickr.image(size: "300x300", search_terms: ['sport']) + "?random=#{index}"
  file = URI.open(image_url)
  event.image.attach(io: file, filename: "event_#{index + 1}.png", content_type: "image/png")
  end
end
