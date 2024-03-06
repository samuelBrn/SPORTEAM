class FavouritesController < ApplicationController

  before_action :set_favourite, only: [:destroy]

  def new
    @user = current_user
    @favourite = Favourite.new
  end

  def create
    @fav = Favourite.new(category: Category.find(params[:category_id]), user: current_user)
    @fav.save
    redirect_to dashboard_path
  end

  def destroy
    @favourite.destroy
    redirect_to dashboard_path, status: :see_other
  end

  private

  def set_favourite
    @favourite = Favourite.find(params[:id])
  end

end
