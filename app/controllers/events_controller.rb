class EventsController < ApplicationController
    before_action :set_event, only: %i[show edit update destroy]

    def index
      # Commencer par tous les événements si l'utilisateur n'est pas connecté
      @events = Event.all
    
      # {"location"=>"Paris", "categories"=>["9", "7", "8"], "schedule"=>"7"}
      # Si l'utilisateur est connecté, limiter d'abord les événements à ses catégories favorites

      # Si des catégories sont sélectionnées via le formulaire, filtrer par ces catégories
      if params[:categories].present?
        @events = @events.where(category_id: params[:categories])
      else
        @events = @events.where(category_id: current_user.categories.pluck(:id))
      end

      # if params[:schedule].present?
      #   @events = @events.where("start_at >= ? AND end_at <= ?", DateTime.now, DateTime.now + 8.day)
      # end

      # Préparer les données pour la carte
      @markers = @events.geocoded.map do |event|
        {
          image: view_context.asset_path("#{event.category.sport.downcase}.png"),
          lat: event.latitude,
          lng: event.longitude,
          event_id: event.id,
          info_window_html: render_to_string(partial: "info_window", locals: { event: event })
          # Assurez-vous que le chemin de l'icône de catégorie est correct et que le fichier existe.
          # image: view_context.asset_path("#{event.category.sport.downcase}.png")
        }
      end

    end

  def search
    @categories = Category.order(:sport)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user

    if @event.save
      Participation.create(user: current_user, event: @event)
      redirect_to dashboard_path, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  def edit
    if current_user != @event.user
      redirect_to @event, alert: 'You are not authorized to edit this event.'
    end
  end

  def update
    if current_user != @event.user
      return redirect_to @event, alert: 'You are not authorized to edit this event.'
    end

    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :image, :description, :category_id, :adress, :start_at, :end_at, :status, :max_player, :min_player)
  end
end
