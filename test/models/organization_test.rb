require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  before do
    @user = create(:user)
    @organization = build(:organization, user: @user)
  end

  it 'must belong to a user' do
    @organization.user = nil
    assert @organization.invalid?
    @organization.save
    assert @organization.errors[:user].present?
  end

  it 'must have a name' do
    @organization.name = nil
    assert @organization.invalid?    
    @organization.save
    assert @organization.errors[:name].present?
  end  

  it 'must have an about description' do
    @organization.about = nil
    assert @organization.invalid?    
    @organization.save
    assert @organization.errors[:about].present?
  end  

end
