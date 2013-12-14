require 'test_helper'

class EventTest < ActiveSupport::TestCase

  before do
    @user = create(:user)
    @organization = create(:organization, user: @user)
    @event = build(:event, eventable: @user)
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
end
