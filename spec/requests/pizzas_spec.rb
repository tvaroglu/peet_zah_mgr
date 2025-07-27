require 'rails_helper'

RSpec.describe "Pizzas", type: :request do
  let!(:topping1) { Topping.create!(name: "Cheese") }
  let!(:topping2) { Topping.create!(name: "Pepperoni") }

  describe "GET /pizzas" do
    it "lists all pizzas" do
      Pizza.create!(name: "Margherita", description: "Classic", toppings: [ topping1 ])
      get "/pizzas"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Margherita")
    end
  end

  describe "POST /pizzas" do
    context "with valid attributes" do
      it "creates a pizza with toppings" do
        expect {
          post "/pizzas", params: { pizza: { name: "Veggie", description: "Fresh", topping_ids: [ topping1.id, topping2.id ] } }
        }.to change(Pizza, :count).by(1)

        expect(response).to redirect_to(pizzas_path)
        follow_redirect!
        expect(response.body).to include("Pizza successfully created!")
      end
    end

    context "with invalid attributes" do
      it "fails without a name" do
        post "/pizzas", params: { pizza: { name: "", description: "No name" } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Name can&#39;t be blank")
      end
    end
  end

  describe "PATCH /pizzas/:id" do
    let!(:pizza) { Pizza.create!(name: "Old Name", description: "To be updated") }

    it "updates pizza name and toppings" do
      patch "/pizzas/#{pizza.id}", params: { pizza: { name: "New Name", topping_ids: [ topping1.id ] } }
      expect(response).to redirect_to(pizzas_path)
      follow_redirect!
      expect(response.body).to include("Pizza successfully updated!")
      expect(pizza.reload.name).to eq("New Name")
    end

    it "fails without a name" do
      patch "/pizzas/#{pizza.id}", params: { pizza: { name: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include("Name can&#39;t be blank")
    end
  end

  describe "DELETE /pizzas/:id" do
    let!(:pizza) { Pizza.create!(name: "To Delete", description: "Remove me") }

    it "deletes a pizza" do
      expect {
        delete "/pizzas/#{pizza.id}"
      }.to change(Pizza, :count).by(-1)

      expect(response).to redirect_to(pizzas_path)
      follow_redirect!
      expect(response.body).to include("Pizza successfully deleted!")
    end

    it "returns 404 for invalid id" do
      delete "/pizzas/0"
      expect(response).to have_http_status(:not_found)
    end
  end
end
