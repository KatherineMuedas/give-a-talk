class EventsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy]
  before_action :set_current_user, only: [ :new, :edit, :create, :update, :destroy]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :check_organization
  
  def index
    if @organization
      @events= @organization.events
    else
      @events = Event.all
    end
  end

  def show
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
    # @organization ||= Organization.friendly.find(event_params[:eventable])
    if event_params.has_key?('eventable')
      eventable = JSON.parse(event_params['eventable'])
      @event = Event.new(event_params.except!('eventable'))
      @event.eventable_type = eventable.first
      @event.eventable_id = eventable.last
    else
      @event = Event.new(event_params)
    end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :begins_at, :ends_at, :website, :eventable, :eventable_id, :eventable_type)
    end
end
