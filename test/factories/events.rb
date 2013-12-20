# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name                            { Faker::Conference.name }
    description                     { Faker::HipsterIpsum.paragraph }   
    begins_at                       { Time.now + 1.week }
    ends_at                         { Time.now + 1.week + 3.hours }
    website                         { Faker::Internet.http_url }
    talks_type                      "lightning"
    talks_duration                  5
    talks_slots                     20
    talks_submissions_limit         nil
  end
end
