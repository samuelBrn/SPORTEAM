class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :design ]

  def home

  end

  def design
  end

  def profile
  end

  def dashboard
    @events = current_user.events
    @user_favourites = current_user.favourites
    @user_categories = current_user.categories
    @other_categories = Category.where.not(id: current_user.categories.pluck(:id))
  end

  def update_profile
    if current_user.update(user_params)
      redirect_to dashboard_path, notice: 'Profile updated successfully.'
    else
      @events = current_user.events
      @user_favourites = current_user.favourites
      @user_categories = current_user.categories
      @other_categories = Category.where.not(id: current_user.categories.pluck(:id))
      flash.now[:alert] = 'There was a problem updating your profile.'
      render :dashboard
    end
  end

  private

  def user_params
    params.require(:user).permit(:address, category_ids: [])
  end
end
