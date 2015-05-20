require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:user_1) { create(:user) }

  describe "#new" do
    it "instantiates a new user variable" do
      get :new
      expect(assigns(:user)).to be_a_new(User)  
    end
  end

  describe "#create" do
    context "with valid parameters" do
      def valid_request
        post :create, {user: {
                        first_name: "Jason",
                        last_name: "Tam",
                        email: "jason@tam.com",
                        password: "abcd1234",
                        password_confirmation: "abcd1234"
                      }}
      end

      it "creates a user in the database" do
        expect { valid_request }.to change {User.count}.by(1)
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be  
      end

      it "redirects to the ideas index page" do
        valid_request
        expect(response).to redirect_to(reports_path)
      end

    end

    context "with invalid parameters" do
      def invalid_request
          post :create, {user: {
                          password: "secret",
                          password_confirmation: "secret"
                        }}
      end
      it "doesnt create a user record in the database" do
        expect {invalid_request}.to_not change { User.count }
      end
      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new) 
      end
      it "sets an alert flash message" do
        invalid_request
        expect(flash[:alert]).to be 
      end
    end
  end

  describe "#show" do
    before { get :show, id: user.id }
    it "renders the show template" do
      expect(response).to render_template(:show)
    end
    it "sets and instance variable with the user whose id is passed" do
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "#edit" do
    before { get :edit, id: user.id }
    it "renders the edit template" do
      expect(response).to render_template(:edit)
    end
    it "sets and instance variable with the user whose id is passed" do
      expect(assigns(:user)).to eq(user)
    end
  end

end
