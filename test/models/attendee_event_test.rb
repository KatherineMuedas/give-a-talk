require 'test_helper'

class AttendeeEventTest < ActiveSupport::TestCase
  before do
    @user = create(:user)
    @event = create(:event, eventable: @user)
    @attendee_event = build(:attendee_event, user: @user, event: @event)
  end

  it 'must belong to a user' do
    @attendee_event.user = nil
    assert @attendee_event.invalid?
    @attendee_event.save
    assert @attendee_event.errors[:user].present?
  end

  it 'must belong to a event' do
    @attendee_event.event = nil
    assert @attendee_event.invalid?
    @attendee_event.save
    assert @attendee_event.errors[:event].present?
  end
end
