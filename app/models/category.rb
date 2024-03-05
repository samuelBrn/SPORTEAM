class Category < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :favourites
  has_many :users, through: :favourites
end
