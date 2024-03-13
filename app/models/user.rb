class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :participations
  has_many :events, through: :participations
  has_many :favourites
  has_many :favourite_categories, through: :favourites, source: :category
  has_many :categories, through: :favourites
  has_one_attached :avatar

  def find_participation_for(event)
    participations.find_by(event: event)
  end

  def events_this_month
    events.joins(:participations)
          .where('participations.created_at >= ? AND participations.created_at <= ?', beginning_of_month, end_of_month)
  end

  def next_event
    events.where('start_at > ?', Time.current).order(start_at: :asc).first
  end

  def next_events
    events.where('start_at > ?', Time.current).order(start_at: :asc)
  end

  def past_events
    events.where('start_at <= ?', Time.current).order(start_at: :desc)
  end

  private

  # Premier jour du mois en cours
  def beginning_of_month
    Date.today.beginning_of_month
  end

  # Dernier jour du mois en cours
  def end_of_month
    Date.today.end_of_month
  end

end
