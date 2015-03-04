FactoryGirl.define do
  factory :report do
    sequence(:title) {|n| "#{Faker::Company.bs}-#{n}"}
    description Faker::Lorem.paragraph
  end
end