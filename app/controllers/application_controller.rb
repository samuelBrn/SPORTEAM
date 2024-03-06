class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protected

  def after_sign_up_path_for(resource)
    dashboard_path # Assure-toi que `dashboard_path` est le chemin correct vers ton tableau de bord
  end
end
