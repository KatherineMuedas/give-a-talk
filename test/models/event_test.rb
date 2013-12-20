require 'test_helper'

class EventTest < ActiveSupport::TestCase

  before do
    @user = create(:user)
    @organization = create(:organization, user: @user)
    @event = build(:event, eventable: @user)
    @created_event = create(:event, eventable: @user)
  end

  it 'must belong to a eventable object (user/organization)' do
    @event.eventable = nil
    @event.save
    assert @event.errors[:eventable].present?
    assert @event.invalid?
  end


  it 'must have a name' do
    @event.name = nil
    assert @event.invalid?    
    @event.save
    assert @event.errors[:name].present?
    
  end

  it 'must have a description' do
    @event.description = nil
    assert @event.invalid?   
    @event.save
    assert @event.errors[:description].present?
  end

  it 'must have a begins_at time if it has an ends_at time' do
    @event.begins_at = nil
    @event.ends_at = Time.now
    assert @event.invalid? 
    @event.save
    assert @event.errors[:begins_at].present?
  end

  it 'must begin before it ends' do
    @event.begins_at = Time.now
    @event.ends_at = @event.begins_at - 10.minutes
    assert @event.invalid?
    @event.save
    assert @event.errors[:ends_at].present?
  end

  it 'must have valid talks type' do
    @event.talks_type = Faker::HipsterIpsum.word
    assert @event.invalid?
    @event.save
    assert @event.errors[:talks_type].present?
  end

  it 'returns the number of talks submitted' do
    assert_equal @event.talks_submitted, "#{@event.talks.count.to_s}#{'/'.to_s + @event.talks_submissions_limit.to_s if @event.talks_submissions_limit.present? }"
  end

  it 'returns the number of filled talks' do
    assert_equal @event.filled_talks, "#{@event.talks.accepted.count.to_s}#{'/'.to_s + @event.talks_slots.to_s if @event.talks_slots.present?}"
  end

  it 'adds a user to the attendee list' do
    assert_difference('@created_event.attendees.count') do
      @created_event.attend(@user)
    end
    assert_includes @created_event.attendees, @user
  end

  it 'removes a user from the attendee list' do
    # first attend the event
    @created_event.attend(@user)
    # then unattend
    assert_difference('@created_event.attendees.count', -1) do
      @created_event.unattend(@user)
    end
    refute_includes @created_event.attendees, @user
  end

end
