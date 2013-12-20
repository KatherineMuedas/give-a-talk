require 'test_helper'

class LocationsControllerTest < ActionController::TestCase
  before do
    @user = create(:user)
    @new_location = build(:location, locateable: @user)
    @location = create(:location, locateable: @user)
    @event = create(:event, eventable: @user)
    sign_in @user
    
  end
  
  test "should create a location and render location modal" do
    request.env["HTTP_REFERER"] = event_path(@event)
    assert_difference('Location.count', 2) do
      post :create, format: :js,  location: @new_location.attributes, event: {id: @event.id}
    end
    assert_response :success
  end

  test "should set a location for an event" do
    assert_difference('Location.count') do
      get :set_location, format: :js, location_id: @location.id, event_id: @event.id
    end
    assert @event.location
    refute_equal @location, @event.location
    assert_response :success
  end

  test "should destroy a location" do
    assert_difference('Location.count', -1) do
      delete :destroy, format: :js, id: @location
    end
  end
  
end
