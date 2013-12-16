require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    @new_event = build(:event, eventable: @user)
    @event = create(:event, eventable: @user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: @new_event.attributes
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    @event.save
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    patch :update, id: @event, event: { begins_at: @event.begins_at, description: @event.description, ends_at: @event.ends_at, name: @event.name, website: @event.website }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end
