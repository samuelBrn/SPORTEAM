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

    # S'assurer que @user n'est pas nil avant de continuer
    if @user.present?
      # Récupération et tri des événements par date de création décroissante
      @events = @user.events.order(created_at: :desc)
      @next_events = @user.next_events
      @past_events = @user.past_events
      # Le dernier événement créé sera le premier de la liste triée ci-dessus
      @last_event = @events.first

      # Gestion des catégories favorites si des paramètres sont présents
      if params[:categories].present?
        @user.favourites.destroy_all
        params[:categories].each do |category_id|
          @user.favourites.create(category_id: category_id.to_i)
        end
      end

      # Récupération des informations sur les catégories favorites de l'utilisateur
      @user_favourites = @user.favourites
      @user_categories = @user.categories
      @other_categories = Category.where.not(id: @user.categories.pluck(:id))

      # Récupération du prochain événement
      @next_event = @user.next_event # Assurez-vous que cette méthode existe et fonctionne correctement.
    else
      # Rediriger l'utilisateur vers la page de connexion avec un message si @user est nil
      redirect_to new_user_session_path, alert: "You must be logged in to access this page."
    end
  end


  private

  def user_params
    params.require(:user).permit(:address, category_ids: [])
  end
end
