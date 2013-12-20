require 'test_helper'

class TalkTest < ActiveSupport::TestCase
  before do
    @user = create(:user)
    @talk = build(:talk, user: @user)
    @event = create(:event, eventable: @user)
    @event_talk = @event.talks.create attributes_for(:talk, user: @user)
  end

  it 'must belong to a user' do
    @talk.user = nil
    assert @talk.invalid?
    @talk.save
    assert @talk.errors[:user].present?
  end

  it 'must have a talk type' do
    @talk.talk_type = nil
    assert @talk.invalid?
    @talk.save
    assert @talk.errors[:talk_type].present?
  end

  it 'must have a valid talk type' do
    @talk.talk_type = Faker::HipsterIpsum.word
    assert @talk.invalid?
    @talk.save
    assert @talk.errors[:talk_type].present?
  end

  it 'must have a title' do
    @talk.title = nil
    assert @talk.invalid?
    @talk.save
    assert @talk.errors[:title].present?
  end

  it 'must have a description' do
    @talk.description = nil
    assert @talk.invalid?
    @talk.save
    assert @talk.errors[:description].present?
  end  

  it 'must have a status' do
    @talk.status = nil
    assert @talk.invalid?
    @talk.save
    assert @talk.errors[:status].present?
  end

  it 'must have a valid status' do
    @talk.status = Faker::HipsterIpsum.word
    assert @talk.invalid?
    @talk.save
    assert @talk.errors[:status].present?
  end  

  it 'must inherit default properties from an event & validates' do
    assert_equal @event_talk.talk_type, @event.talks_type
    assert_equal @event_talk.duration, @event.talks_duration
    # let's change the talk type & duration
    @event_talk.talk_type = 'conference'
    @event_talk.duration = 30
    @event_talk.save
    # should be reset to event talks_type & duration and still pass
    refute_equal @event_talk.talk_type, 'conference'
    refute_equal @event_talk.duration, 30

    assert_equal @event_talk.talk_type, @event.talks_type
    assert_equal @event_talk.duration, @event.talks_duration    
  end
  
  it 'cannot submit a new talk to an event if an event submission limit has been met' do
    @event.update_attributes(talks_submissions_limit: 10)
    10.times do
      @event.talks.create(attributes_for(:talk, user: @user))
    end
    event_talks_count = @event.talks.count
    assert_no_difference("Talk.count") do
      @new_talk = @event.talks.create(attributes_for(:talk, user: @user))
    end
    assert @new_talk.errors[:base].present?
    assert_equal @event.talks_submissions_limit, 10
  end

  it 'cannot submit a new talk to an event if the event has a submissions end at time that has passed' do
    @event.update_attributes(submissions_end_at: Time.now - 1.day)
    assert_no_difference("Talk.count") do
      @new_talk = @event.talks.create(attributes_for(:talk, user: @user))
    end
    assert @new_talk.errors[:base].present?
  end

end
