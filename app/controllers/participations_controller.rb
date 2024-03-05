class ParticipationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @event = Event.find(params[:event_id])
    @participation = Participation.new
  end

  def instant_create
    @event = Event.find(params[:event_id])
    @participation = Participation.new(event: @event, user: current_user)

    if @event.participations.count < @event.max_player
      if @participation.save
        redirect_to event_path(@event), notice: 'Vous êtes bien inscrit à l\'évènement.'
      else
        redirect_to event_path(@event), alert: 'Un problème est survenu lors de votre inscription.'
      end
    else
      redirect_to event_path(@event), alert: 'L\'événement a atteint le nombre maximum de participants.'
    end
  end
end
