require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "#index" do
    it "renders a index template" do
      get :index
      expect(response).to render_template(:index)
    end
    it "assigns a new search instance" do
      get :index
      expect(assigns(:search)).to be_a_new(Search)
    end
    it "has a 200 status code" do
      expect(response.code).to eq("200")
    end
  end
end
