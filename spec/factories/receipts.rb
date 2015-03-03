FactoryGirl.define do
  factory :receipt do
    business_name Faker::Company.name
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'receipt.jpg'))}
    tax_type "GST"
  end
end
