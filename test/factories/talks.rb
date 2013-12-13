# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :talk do
    talk_type           "MyString"
    title               "MyString"
    description         "MyText"
    justification       "MyText"
    video               "MyString"
    presentation        "MyString"
    status              "MyString"
    resources           ""
  end
end
