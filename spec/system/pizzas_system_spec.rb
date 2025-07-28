require 'rails_helper'

RSpec.describe "Pizzas management", type: :system do
  let!(:topping1) { Topping.create!(name: "Cheese") }
  let!(:topping2) { Topping.create!(name: "Pepperoni") }

  it "lists pizzas and creates a new pizza" do
    visit pizzas_path
    expect(page).to have_content("Pizzas")
    within("div.mb-4") { click_link "New Pizza", wait: true }

    fill_in "Name", with: "Margherita", wait: true
    fill_in "Description", with: "Classic pizza", wait: true
    check "Cheese", wait: true
    check "Pepperoni", wait: true
    click_button "Create Pizza", wait: true

    expect(page).to have_content("Pizza successfully created!")
    expect(page).to have_content("Margherita")
    expect(page).to have_content("Cheese")
    expect(page).to have_content("Pepperoni")
  end

  it "shows validation errors when creating invalid pizza" do
    visit new_pizza_path
    fill_in "Name", with: "", wait: true
    fill_in "Description", with: "Invalid pizza", wait: true
    click_button "Create Pizza", wait: true

    expect(page).to have_content("Name can't be blank")
  end

  it "edits an existing pizza" do
    pizza = Pizza.create!(name: "Veggie", description: "Fresh", toppings: [ topping1 ])

    visit pizzas_path
    within(".py-3", text: "Veggie") { click_link "Edit", wait: true }

    fill_in "Name", with: "Veggies", wait: true
    uncheck "Cheese", wait: true
    check "Pepperoni", wait: true
    click_button "Update Pizza", wait: true

    expect(page).to have_content("Pizza successfully updated!")
    expect(page).to have_content("Veggies")
    expect(page).to have_content("Pepperoni")
    expect(page).not_to have_content("Cheese")
  end

  it "deletes a pizza upon confirmation" do
    pizza = Pizza.create!(name: "Placeholder", description: "Temporary", toppings: [ topping1 ])

    visit pizzas_path
    within("#pizza-#{pizza.id}", text: "Placeholder") do
      accept_confirm do
        click_button "Delete", wait: true
      end
    end

    expect(page).to have_content("Pizza successfully deleted!")
    expect(page).not_to have_content("Placeholder")
  end

  it "does not delete a pizza if not confirmed" do
    pizza = Pizza.create!(name: "Placeholder", description: "Temporary", toppings: [ topping1 ])

    visit pizzas_path
    within("#pizza-#{pizza.id}", text: "Placeholder") do
      accept_confirm do
        click_button "Delete", wait: true
      end
    end

    expect(page).to have_content("Pizza successfully deleted!")
    expect(page).not_to have_content("Placeholder")
  end
end
