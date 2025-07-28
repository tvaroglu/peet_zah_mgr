require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let!(:user) { User.create!(username: "login_user", password: "password", role: User::ROLE_CHEF) }

  describe "GET /login" do
    it "renders the login form" do
      get login_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Login to Peet Zah Mgr")
    end
  end

  describe "POST /login" do
    it "logs in a valid user and redirects" do
      post login_path, params: { username: "login_user", password: "password" }
      expect(session[:user_id]).to eq(user.id)
      expect(response).to redirect_to(pizzas_path)
    end

    it "re-renders on invalid credentials" do
      post login_path, params: { username: "login_user", password: "wrong" }
      expect(session[:user_id]).to be_nil
      expect(response.body).to include("Invalid username or password.")
    end
  end

  describe "DELETE /logout" do
    it "logs out the user and redirects to login" do
      delete logout_path
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(login_path)
    end
  end
end
