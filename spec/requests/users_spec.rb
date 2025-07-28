require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /new" do
    it "renders the signup form" do
      get new_user_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Create Account")
    end
  end

  describe "POST /users" do
    let(:valid_params) do
      { user: { username: "signup_user", password: "password", password_confirmation: "password", role: User::ROLE_MANAGER } }
    end

    it "creates a new user and redirects to pizzas" do
      expect {
        post users_path, params: valid_params
      }.to change(User, :count).by(1)

      expect(response).to redirect_to(pizzas_path)
      follow_redirect!
      expect(response.body).to include("Account successfully created!")
    end

    it "re-renders form on invalid input" do
      post users_path, params: { user: { username: "", password: "" } }
      expect(response.body).to include("Failed to create account.")
    end
  end
end
