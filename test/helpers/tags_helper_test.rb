require "test_helper"

class TagsHelperTest < ActionView::TestCase

  before do
    user = create(:user)
    5.times do 
      user.tags.create(attributes_for(:tag))
    end
    @taggable_object = user
  end
  
  it "displays all the html tags for a taggable object" do
    assert_equal display_tags(@taggable_object), expected_tags_html
  end

  def expected_tags_html
    if @taggable_object.tags.present?
      content_tag :p do
        @taggable_object.tags.each do |tag|
          concat content_tag :span, tag.name, class: 'label round' 
        end
      end
    end
  end
  
end
