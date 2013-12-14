require "test_helper"

describe ApplicationHelper do
  it 'displays base errors for a resource' do
    @user = build(:user)
    @user.errors[:base] << "trap"
    display_base_errors(@user).must_match "<p>trap</p>"
  end
end

