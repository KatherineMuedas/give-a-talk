require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  before do
    @user = create(:user)
    @event = build(:event, eventable: @user)
    @location = build(:location, locateable: @event)  
  end
end
