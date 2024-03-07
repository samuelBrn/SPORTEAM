class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if user_signed_in?
      @user_categories_ids = current_user.categories.pluck(:id)
      @events = Event.where(category_id: @user_categories_ids)
    else
      @events = Event.all
    end

    @markers = @events.geocoded.map do |event|
      {
        image: view_context.asset_path("#{event.category.sport.downcase}.png"),
        lat: event.latitude,
        lng: event.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { event: event })
      }
    end
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
    params.require(:event).permit(:name, :description, :category_id, :adress, :start_at, :end_at, :status, :max_player, :min_player)
  end
end
