require 'test_helper'

class TalkTest < ActiveSupport::TestCase
  before do
    @user = create(:user)
    @talk = build(:talk, user: @user)
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


  
end
