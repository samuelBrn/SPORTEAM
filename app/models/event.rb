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

  def duration
    dif_time = end_at - start_at
    hour = dif_time / 3600
    min = (dif_time % 3600) / 60
    min < 10 ? "#{hour.to_i}h0#{min.to_i}" : "#{hour.to_i}h#{min.to_i}"
  end

  def participant_gauge
    (participations.count.fdiv(max_player) * 100).round
  end

end
