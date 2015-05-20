require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  describe "#new" do
    before { get :new }
    it "sets a user instance variable" do
      expect(assigns(:user)).to be_a_new(User)
    end
    it "renders the new template" do
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "successful login" do
      def valid_request
        post :create, {email: user.email, password: user.password}
      end

      before { valid_request }

      it "sets the session user_id to be the id of the user" do
        expect(session[:user_id]).to eq(user.id)
      end
      it "redirects to the reports index view" do
        expect(response).to redirect_to(reports_path) 
      end
      it "shows an notice message that says logged in successfully" do
        expect(flash[:notice]).to be
      end
    end

    context "unsuccessful login" do
      def invalid_request
        post :create,  {email: user.email, password: user.password + "nah"}
      end

      before { invalid_request }

      it "doesnt create a session" do
        expect(session[:user_id]).not_to be
      end
      it "doesnt set the session user_id" do
        expect(session[:user_id]).to eq(nil)
      end
      it "renders the new template" do
        expect(response).to render_template(:new)
      end
      it "sets an alert flash message" do
        expect(flash[:alert]).to be
      end

    end
  end

end

