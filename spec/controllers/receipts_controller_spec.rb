require 'rails_helper'

RSpec.describe ReceiptsController, type: :controller do
  let(:report) {create(:report)}
  let(:receipt) {create(:receipt, report: report)}
  let(:receipt_1) {create(:receipt)}


  describe "#new" do
    it "renders a new template" do
      get :new, {:report_id => report.id}
      expect(response).to render_template(:new)
    end
    it "assigns a new receipt instance" do
      get :new, {:report_id => report.id}
      expect(assigns(:receipt)).to be_a_new(Receipt)
    end
    it "has a 200 status code" do
      expect(response.code).to eq("200")
    end

  end # new end

  describe "#create" do
    context "with valid parameters" do
      # before(:each) do
      #   @report = FactoryGirl.build(:report)
      #   @receipt_attributes = FactoryGirl.attributes_for(:receipt, :report_id => @report.id)
      # end

      def valid_request
        # post :create, :report_id => @report.id, :receipt => @receipt_attributes
        post :create, {receipt: { tax_type: "GST",
                                  image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'receipt.jpg'))},
                                  report_id: report.id}
      end

      it "adds a receipt to the database" do
        expect { valid_request }.to change { Receipt.count }.by(1)
      end
      it "redirects to receipt show page" do
        valid_request
        expect(response).to redirect_to(report_path(report))
      end
      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end      
      it "has a 302 status code for a good redirect" do
        valid_request
        expect(response.code).to eq("302")
      end

    end  # end of create with valid params

    context "with invalid parameters" do
      def invalid_request
        post :create, {receipt: { tax_type: nil,
                                  image: nil},
                                  report_id: report.id}
      end
      
      it "doesn't create a record in the database" do
        expect { invalid_request }.not_to change {Receipt.count}
      end

      it "redirects back" do
        invalid_request
        expect(response).to redirect_to(report_path(report))
      end
      it "sets a flash alert message" do
        invalid_request
        expect(flash[:notice]).to be
      end
      it "has a 302 status code for a good redirect" do
        invalid_request
        expect(response.code).to eq("302")
      end
    end #create context invalid request end
  end #create end


end # Rspec end
