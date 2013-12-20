require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    @new_event = build(:event, eventable: @user)
    @event = create(:event, eventable: @user)
    @organization = @user.organizations.create attributes_for(:organization)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get index for an organization" do
    get :index, organization_id: @organization.id
    assert_response :success
    assert_not_nil assigns(:events)
    assert_not_nil assigns(:organization)
  end

  test "should get new" do
    get :new
    assert_not_nil assigns(:event)
    assert_response :success
  end

  test "should get new for an organization" do
    get :new, organization_id: @organization.id
    assert_response :success
    assert_not_nil assigns(:event)
    assert_not_nil assigns(:organization)
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
    assert_not_nil assigns(:event)
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

  test "should allow user to attend event when signed in" do
    assert_difference('@event.attendees.count') do
      post :attend, format: :js, id: @event.id
    end
    assert_includes @event.attendees, @user
  end

  test "should allow user to unattend event when signed in" do
    # first attend the event
    post :attend, format: :js, id: @event.id
    # then unattend
    assert_difference('@event.attendees.count', -1) do
      post :unattend, format: :js, id: @event.id
    end
    refute_includes @event.attendees, @user
  end

end
