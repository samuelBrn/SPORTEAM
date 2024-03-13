class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :design ]

  def home

  end

  def design
  end

  def profile
  end

  def dashboard
    @user = current_user
    @events = current_user.events
    if params[:categories].present?
      current_user.favourites.destroy_all
      params[:categories].each do |category|
        current_user.favourites.create(category_id: category.to_i)
      end
    end
    @user_favourites = current_user.favourites
    @user_categories = current_user.categories
    @other_categories = Category.where.not(id: current_user.categories.pluck(:id))
    @next_event = @user.next_event
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
