# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    name  { Faker::DizzleIpsum.word }
  end
end
