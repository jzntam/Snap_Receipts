require 'rails_helper'

RSpec.describe SearchesController, type: :controller do

  describe "#new" do
    it "renders a new template" do
      get :new
      expect(response).to render_template(:new)
    end
    it "assigns a new search instance" do
      get :new
      expect(assigns(:search)).to be_a_new(Search)
    end
    it "has a 200 status code" do
      expect(response.code).to eq("200")
    end
  end

  describe "#create" do
    context "with valid parameters" do
      def valid_request
        post :create, {search: {
                        keyword: "Car"}
                      }
      end

      it "adds a search to the database" do
        expect { valid_request }.to change { Search.count }.by(1)
      end
      it "redirects to search show page" do
        valid_request
        expect(response).to redirect_to(search_path(Search.last))
      end  
      it "has a 302 status code for a good redirect" do
        valid_request
        expect(response.code).to eq("302")
      end

    end  # end of create with valid params

    context "with invalid parameters" do
      def invalid_request
        post :create, {search: {
                        keyword: nil}
                      }
      end
      
      it "still creates a record in the database" do
        expect { invalid_request }.to change {Search.count}
      end
      it "redirects back" do
        invalid_request
        expect(response).to redirect_to(search_path(Search.last))
      end
      it "has a 302 status code for a good redirect" do
        invalid_request
        expect(response.code).to eq("302")
      end
    end # end of create with invalid params

  end # end of create

  describe "#show" do
    it "assigns a search instance variable with passed id" do
      search = FactoryGirl.create(:search)
      get :show, id: search.id
      expect(assigns(:search)).to eq(search)
    end
    it "renders the show template" do
      search = FactoryGirl.create(:search)
      get :show, id: search.id
      expect(response).to render_template(:show)
    end
    it "has a 200 status code for a good get response" do
      expect(response.code).to eq("200")
    end
  end # end of show

end
