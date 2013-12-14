require 'test_helper'

class TagTest < ActiveSupport::TestCase
  before do
    @user = create(:user)
    @tag = build(:tag, taggable: @user)
  end

  it "is valid with our defaults" do
    assert @tag.valid?
  end

  it 'must belong to a taggable object' do
    @tag.taggable = nil
    assert @tag.invalid?
    @tag.save
    assert @tag.errors[:taggable].present?
  end

  it "always has a name" do
    @tag.name = nil
    assert @tag.invalid?
  end
end
