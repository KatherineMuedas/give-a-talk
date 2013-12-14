# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :talk do
    talk_type           "lightning"
    title               { Faker::Conference.name }
    description         { Faker::Lorem.paragraph }
    justification       { Faker::HipsterIpsum.paragraph }
    video               { Faker::Internet.http_url }
    presentation        { Faker::Internet.http_url }
    status              "pending"
    resources           { {github: "http://www.github.com/#{Faker::HipsterIpsum.word}", homepage: Faker::Internet.http_url} }
  end
end
