FactoryGirl.define do
  factory :receipt do
    business_name Faker::Company.name
    image do
      Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/public/receipt.jpg')))
    end
    tax_type "GST"
  end
end
