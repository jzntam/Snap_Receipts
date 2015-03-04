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

  describe "#index" do
    it "renders a new template" do
      get :index, {:report_id => report.id}
      expect(response).to render_template(:index)
    end
    it "assigns receipts variable for all created receipts" do
      receipt
      receipt_1
      get :index, {:report_id => report.id}
      expect(assigns(:receipts)).to eq([receipt, receipt_1])
    end
    it "finds the 'Report' with passed id and stores it in instance var" do
      # receipt = FactoryGirl.create(:receipt)
      receipt
      get :index, id: receipt.id, report_id: report.id
      expect(assigns(:report)).to eq(report)
    end
    it "has a 200 status code" do
      expect(response.code).to eq("200")
    end
  end # end of index

  describe "#edit" do
    
    it "retrieves the receipt with passed id and stores it in instance var" do
      # receipt = FactoryGirl.create(:receipt)
      get :edit, id: receipt.id, report_id: report.id
      expect(assigns(:receipt)).to eq(receipt)
    end
    it "shows the edit page" do
      get :edit, id: receipt.id, report_id: report.id
      expect(response.code).to eq("200")
    end
  end # end of edit



  describe "#update" do
    context "with valid request" do
      before do
        patch :update, {id: receipt.id,
                        report_id: report.id,
                        receipt: { tax_type: "PST",
                                   image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'receipt.jpg'))}}
      end
      it "redirects to the receipt page / report show page" do
        expect(response).to redirect_to(report_path(report))
      end
      it "changes the image of the receipt if it's different" do
        expect(receipt.reload.image).to eq(receipt.image)
      end
      it "changes the tax_type of the receipt if it's different" do
        expect(receipt.reload.tax_type).to eq("PST")
      end
      it "sets a notice flash message" do
        expect(flash[:notice]).to be
      end
      it "has a 302 status code for a good redirect" do
        expect(response.code).to eq("302")
      end
    end # end of update with valid params

    context "with invalid params" do
      before do
        patch :update, {id: receipt.id,
                        report_id: report.id,
                        receipt: { tax_type: nil,
                                   image: nil}}
      end
      it "renders the edit page" do
        expect(response).to redirect_to(report_path(report))
      end
      it "Missing tax_type doesn't change the database" do
        expect(receipt.reload.tax_type).not_to eq("")
      end
      it "Missing image doesn't change the database" do
        expect(receipt.reload.image).to eq(receipt.image)
      end
      it "sets an alert flash message" do
        expect(flash[:notice]).to be
      end
      it "has a 302 status code for a good redirect" do
        expect(response.code).to eq("302")
      end
    end # end of update with INvalid params
  end # end of  update with valid params

  describe "#destroy" do

    context "Good delete request" do
      # let!(:receipt) { create(:receipt, report: report) }
      before do
        # delete :destroy, {id: receipt.id, report_id: report.id}
      end

      it "retrieves the receipt with passed id and stores it in instance var" do
        # receipt = FactoryGirl.create(:receipt)
        delete :destroy, id: receipt.id, report_id: report.id
        expect(assigns(:receipt)).to eq(receipt)
      end
      it "deletes the report from the database" do
        # puts receipt.inspect
        # expect {
          delete :destroy, id: receipt.id, report_id: report.id
        # }.to change{ Receipt.count }.by(-1)
        expect(Receipt.find_by_id(receipt.id)).to eq(nil)
      end
      it "redirect to the show page" do
        delete :destroy, {id: receipt.id, report_id: report.id}
        expect(response).to redirect_to(report_path(report))
      end
      it "sets a flash message" do
        delete :destroy, {id: receipt.id, report_id: report.id}
        expect(flash[:notice]).to be
      end
      it "has a 200 status code for a good redirect for delete" do
        expect(response.code).to eq("200")
      end
    end # end of destroy with valid params

    context "with invalid params" do
      it "does not delete the receipt from the database" do
        # delete :destroy, {id: receipt.id, report_id: report.id}
        # expect { delete :destroy, id: receipt.id }.to_not change { Receipt.count }
        expect(Receipt.find_by_id(receipt.id)).not_to eq(nil)
      end
      it "redirect to the show page" do
        delete :destroy, id: receipt.id, report_id: report.id
        expect(response).to redirect_to(report_path(report))
      end
      it "sets a flash message" do
        delete :destroy, id: receipt.id, report_id: report.id
        expect(flash[:notice]).to be
      end
      it "has a 200 status code for a good get response" do
        expect(response.code).to eq("200")
      end
    end # end of destroy with INvalid params
  end # end of destroy


end # Rspec end
