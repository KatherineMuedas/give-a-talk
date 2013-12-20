# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    name                { Faker::Venue.name }
    street_address      { Faker::Address.street_address }
    secondary_address   { Faker::Address.secondary_address }
    city                { Faker::Address.city }
    region              { Faker::Address.us_state_abbr }
    postal_code         { Faker::Address.zip_code }
    country             { Faker::Address.country }
    instructions        { Faker::Lorem.paragraph }
    map                 { Faker::Internet.http_url }
  end
end
