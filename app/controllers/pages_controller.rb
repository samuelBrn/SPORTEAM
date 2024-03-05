class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def dashboard
    @events = current_user.events
    @favourites = Favourite.all
  end
end
