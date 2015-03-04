require 'rails_helper'

RSpec.describe Receipt, type: :model do

    def receipt_attributes(new_attributes)
      valid_attributes = {image: "valid title",
                          tax_type: "valid desc"}
      valid_attributes.merge(new_attributes)
    end

    it "requires a title" do
      receipt = Receipt.new(receipt_attributes({image: nil}))
      expect(receipt).to be_invalid
    end

    it "requires a description" do
      receipt = Receipt.new(receipt_attributes({tax_type: nil}))
      expect(receipt).to be_invalid
    end

end
