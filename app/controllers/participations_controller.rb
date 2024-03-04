class ParticipationsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @participation = Participation.new
  end

  def create
    @event = Event.find(params[:event_id])
    @participation = Participation.new(participation_params)

    if @participation.save
      redirect_to dashboard_path, notice: 'your participation for this sevent is validated'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def participation_params
    params.require(:participation).permit(:user_id, :event_id, :status)
  end
end
