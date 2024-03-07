class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :design ]

  def home
  end

  def design
  end

  def dashboard
    @events = current_user.events
  end
end
