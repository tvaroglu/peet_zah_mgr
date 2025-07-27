require 'rails_helper'

RSpec.describe "Toppings", type: :request do
  describe "GET /toppings" do
    it "lists all toppings" do
      Topping.create!(name: "Onions")
      get "/toppings"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Onions")
    end
  end

  describe "POST /toppings" do
    context "with valid attributes" do
      it "creates a topping" do
        expect {
          post "/toppings", params: { topping: { name: "Mushrooms" } }
        }.to change(Topping, :count).by(1)

        expect(response).to redirect_to(toppings_path)
        follow_redirect!
        expect(response.body).to include("Topping successfully created!")
      end
    end

    context "with invalid attributes" do
      it "fails without a name" do
        post "/toppings", params: { topping: { name: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Name can&#39;t be blank")
      end
    end
  end

  describe "PATCH /toppings/:id" do
    let!(:topping) { Topping.create!(name: "Old Topping") }

    it "updates topping name" do
      patch "/toppings/#{topping.id}", params: { topping: { name: "New Topping" } }
      expect(response).to redirect_to(toppings_path)
      follow_redirect!
      expect(response.body).to include("Topping successfully updated!")
      expect(topping.reload.name).to eq("New Topping")
    end

    it "fails without a name" do
      patch "/toppings/#{topping.id}", params: { topping: { name: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("Name can&#39;t be blank")
    end
  end

  describe "DELETE /toppings/:id" do
    let!(:topping) { Topping.create!(name: "Remove Me") }

    it "deletes a topping" do
      expect {
        delete "/toppings/#{topping.id}"
      }.to change(Topping, :count).by(-1)

      expect(response).to redirect_to(toppings_path)
      follow_redirect!
      expect(response.body).to include("Topping successfully deleted!")
    end

    it "returns 404 for invalid id" do
      delete "/toppings/0"
      expect(response).to have_http_status(:not_found)
    end
  end
end
