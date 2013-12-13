# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    name      { Faker::Company.name }
    website   { Faker::Internet.http_url }
    about     { Faker::Lorem.paragraph }
  end
end
