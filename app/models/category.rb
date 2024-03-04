class Category < ApplicationRecord
  has_many :events
  has_many :favourites
  has_many :users, through: :favourites
end
