require 'test_helper'

class UserTest < ActiveSupport::TestCase

  before do
    @user = build(:user)
  end

  it 'must have an email' do
    @user.email = nil
    assert @user.invalid?
    @user.save
    assert @user.errors[:email].present?
  end

  it 'must have a valid email' do
    @user.email = 'coolguy@123'
    assert @user.invalid?
    @user.save
    refute_match /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, @user.email
  end

  it 'must have a password on creation' do
    @user.password = nil
    assert @user.invalid?
    @user.save
    assert @user.errors[:password].present?
  end

  it 'owns both its own events and organizations events as all events' do
    # testing without associated events
    assert_equal @user.all_events, @user.events + @user.organization_events
    # testing with a bunch of associated events
    @user.save
    @user.reload
    @user.organizations.create attributes_for(:organization)
    3.times do
      @user.events.create attributes_for(:event)
      @user.organizations.first.events.create attributes_for(:event)
    end
    assert_equal @user.all_events, @user.events + @user.organization_events
  end

  it 'displays a full name & name (alias) properly' do
    assert_equal @user.full_name, [@user.first_name, @user.last_name].join(' ')
    assert_equal @user.name, [@user.first_name, @user.last_name].join(' ')
  end

end
