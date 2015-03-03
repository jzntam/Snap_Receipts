require 'rails_helper'

RSpec.describe ReportsController, type: :controller do

  describe "#index" do
    it "renders a new template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns a new report instance" do
      get :index
      expect(assigns(:report)).to be_a_new(Report)
    end

    # it "assigns a variable for all reports instance" do
    #   get :index
    #   expect(assigns(:report)).to eq(Report.all)
    # end
  end  #end of index

  describe "#create" do
    context "with valid parameters" do
      def valid_request
        post :create, {report: {
                        title: "Valid Report Title",
                        description: "Valid Description"}
                      }
      end

      it "adds a report to the database" do
        expect { valid_request }.to change { Report.count }.by(1)
      end

      it "redirects to report show page" do
        valid_request
        expect(response).to redirect_to(reports_path)
      end
      
      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
      
      it "has a 302 status code" do
        valid_request
        expect(response.code).to eq("302")
      end

      # it { should render_template(:format => 'js', :partial => '_report.html.erb') }

      # it "renders a new template" do
      #   valid_request
      #   expect(subject).to render_template(:index)
      # end

    end

    context "with invalid parameters" do
      def invalid_request
        post :create, {report: {
                        title: nil,
                        description: nil}
                      }
      end
      
      it "doesn't create a record in the database" do
        expect { invalid_request }.not_to change {Report.count}
      end
      
      it "redirects back" do
        invalid_request
        expect(response).to redirect_to(reports_path)
      end
      
      it "sets a flash alert message" do
        invalid_request
        expect(flash[:notice]).to be
      end
    end

  end # end of create

  describe "#show" do
    it "assigns a report instance variable with passed id" do
      report = FactoryGirl.create(:report)
      get :show, id: report.id
      expect(assigns(:report)).to eq(report)
    end
    it "renders the show template" do
      report = FactoryGirl.create(:report)
      get :show, id: report.id
      expect(response).to render_template(:show)
    end
    # it "assigns a new receipt instance" do
    #   get :show
    #   expect(assigns(:receipt)).to be_a_new(Receipt)
    # end

  end

end

