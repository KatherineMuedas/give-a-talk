require 'test_helper'

class TalksControllerTest < ActionController::TestCase
  
  before do
    @user = create(:user)
    sign_in @user
    @event = create(:event, eventable: @user)
    @new_talk = build(:talk)
    @talk = create(:talk, user: @user)
    @event_talk = create(:talk, user: @user, event: @event)
  end

  it "shows a talk" do
    get :show, id: @talk.id
    assert_response :success
    assert_not_nil assigns(:talk)
  end

  it "shows a talk within the context of an event" do
    get :show, id: @event_talk.id
    assert_response :success
    assert_not_nil assigns(:talk)
    assert_not_nil assigns(:event)
  end  

  it "creates a talk without an event" do
    assert_difference('Talk.count') do
      post :create, format: :js, talk: attributes_for(:talk)
    end
    assert_response :success
    assert_not_nil assigns(:talk)
    assert_nil assigns(:event)
  end

  it "creates a talk within the context of an event" do
    assert_difference('Talk.count') do
      post :create, format: :js, talk: attributes_for(:talk), event_id: @event.id
    end
    assert_response :success
    assert_not_nil assigns(:talk)
    assert_not_nil assigns(:event)
  end  

end
