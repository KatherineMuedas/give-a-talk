class TalksController < ApplicationController

  before_action :set_talk, only: [:show]

  def show
    @event = @talk.event if @talk.event
  end

  def create
    @talk = current_user.talks.new(talk_params)
    @talk.event = Event.friendly.find(params[:event_id]) if params.has_key?(:event_id)
    @event = @talk.event if @talk.event
    if @talk.save
      respond_to do |format|
        format.js 
      end
    end    
  end

  private

    def set_talk
      @talk = Talk.friendly.find(params[:id])
    end
    
    def talk_params
      params.require(:talk).permit(:talk_type, :title, :description, :status, :justification, :video, :presentation, :resources, :event_id)

    end

  
end
