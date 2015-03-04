require 'rails_helper'

RSpec.describe Report, type: :model do

  describe "Validations" do

    def report_attributes(new_attributes)
      valid_attributes = {title: "valid title",
                          description: "valid desc"}
      valid_attributes.merge(new_attributes)
    end

    it "requires a title" do
      report = Report.new(report_attributes({title: nil}))
      expect(report).to be_invalid
    end

    it "requires a description" do
      report = Report.new(report_attributes({description: nil}))
      expect(report).to be_invalid
    end

    it "requires the title to be unique" do
      Report.create(report_attributes({title: "abc"}))
      report = Report.new(report_attributes({title: "abc"}))
      expect(report).to be_invalid
    end
  end

  describe 'association' do
    it { should have_many(:receipts) }
  end

  describe 'column_specification' do
    it { should have_db_column(:title).of_type(:string).with_options(presence: true, uniqueness: true) }
    it { should have_db_column(:description).of_type(:text) }
  end

end
