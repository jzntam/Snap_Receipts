FactoryGirl.define do
  factory :report do
    title Faker::Company.bs
    description Faker::Lorem.paragraph
  end
end