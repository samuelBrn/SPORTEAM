class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def dashboard
    @events = current_user.events
    @user_favourites = current_user.favourites
    @user_categories = current_user.categories
    @other_categories = Category.where.not(id: current_user.categories.pluck(:id))
  end
end
