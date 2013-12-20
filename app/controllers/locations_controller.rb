class LocationsController < ApplicationController
  def create
    @event = Event.friendly.find(event_params[:id])
    location = Location.new(location_params)
    respond_to do |format|
      if location.save
        set_location = location.duplicate_for_event(@event.id)
        @locations = location.locateable.locations
        @new_location = @locations.new()
        format.js 
      else
        format.html { render action: 'new' }
      end
    end    
  end

  def set_location
    original_location = Location.friendly.find(params[:location_id])
    @event = Event.friendly.find(params[:event_id])
    @location = original_location.duplicate_for_event(@event.id)

    respond_to do |format|
      format.js
    end
  end

  def subregion_options
    render partial: 'locations/region_select'
  end

  def destroy
    @location = Location.friendly.find(params[:id])
    @location.destroy
    respond_to do |format|
      format.js 
    end
  end


  private

    def location_params
      params.require(:location).permit(:name, :street_address, :secondary_address, :city, :region, :postal_code, :country, :instructions, :map, :url, :locateable_id, :locateable_type, :locateable, :event_id) if params[:location]
    end

    def event_params
      params.require(:event).permit(:id)
    end

end
