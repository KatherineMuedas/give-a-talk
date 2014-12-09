class EventsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy, :attend, :unattend]
  before_action :set_current_user, only: [ :new, :edit, :create, :update, :destroy]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :attend, :unattend]
  before_action :check_organization
  before_action :set_eventable, only: :create 
   
  def index
    if @organization
      @events= @organization.events
    else
      @events = Event.all
    end
  end

  def show
    @locations = @event.eventable.locations
    @new_location = @event.eventable.locations.new()
    @new_talk = current_user.talks.new(talk_type: @event.talks_type)
  end

  def new
    if @organization
      @event = @organization.events.new()
    else
      @event = Event.new()
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def attend
    @event.attend(current_user)
    respond_to do |format|
      format.js
    end
  end

  def unattend
    @event.unattend(current_user)
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_eventable
      if event_params.has_key?('eventable')
        eventable = JSON.parse(event_params['eventable'])
        @event = Event.new(event_params.except!('eventable'))
        @event.eventable_type = eventable.first
        @event.eventable_id = eventable.last
      else
        @event = Event.new(event_params)
      end
    end

    def set_event
      @event = Event.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :begins_at, :ends_at, :website, :eventable, :eventable_id, :eventable_type, :talks_type, :talks_duration, :talks_slots, :submissions_end_at)
    end
end
