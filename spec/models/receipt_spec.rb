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

  describe 'association' do
    it { should belong_to(:report) }
  end

  describe 'column_specification' do
    it { should have_db_column(:business_name).of_type(:string) }
    it { should have_db_column(:sub_total).of_type(:decimal).with_options(precision: 8, scale: 2) }
    it { should have_db_column(:tax_total).of_type(:decimal).with_options(precision: 8, scale: 2) }
    it { should have_db_column(:total).of_type(:decimal).with_options(precision: 8, scale: 2) }
    it { should have_db_column(:tax_type).of_type(:string) }
    it { should have_db_column(:report_id).of_type(:integer) }
    it { should have_db_column(:image).of_type(:string) }
    it { should have_db_column(:category).of_type(:string) }
    it { should have_db_column(:comment).of_type(:string) }
    it { should have_db_column(:address).of_type(:string) }
    it { should have_db_column(:longitude).of_type(:float) }
    it { should have_db_column(:latitude).of_type(:float) }
    it { should have_db_index(:report_id) }
  end

end
