class Event < ApplicationRecord
  belongs_to :category
  has_many :participations
  has_many :users, through: :participations
  has_one_attached :image
  geocoded_by :adress

  after_validation :geocode, if: :will_save_change_to_adress?
end
