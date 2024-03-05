class FavouritesController < ApplicationController
  def new
    @user = current_user
    @favourite = Favourite.new
  end

  def create
    Favourite.new(category: Category.find(params[:category_id]), user: current_user)
  end

  def destroy
  end
end
