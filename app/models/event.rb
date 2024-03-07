class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations
  has_one_attached :image
  geocoded_by :adress
  after_validation :geocode, if: :will_save_change_to_adress?

  def current_participants_count
    participations.count
  end

  def created_event?(user)
    @participation_first = participations.first
    @participation_first.user_id == user.id
  end
end
