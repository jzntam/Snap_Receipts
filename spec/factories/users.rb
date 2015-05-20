FactoryGirl.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    password Faker::Internet.password(8)
    sequence(:email) { |n| "receipt_email_#{n}@gmail.com"}
  end
end
