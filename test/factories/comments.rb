# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    text "MyText"
    reply_to_id 1
    user nil
    commentable nil
  end
end
