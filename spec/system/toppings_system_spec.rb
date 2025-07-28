require 'rails_helper'

RSpec.describe "Toppings management", type: :system do
  it "lists toppings and creates a new topping" do
    visit toppings_path
    expect(page).to have_content("Toppings")

    click_link "New Topping", match: :first, wait: true

    fill_in "Name", with: "Mushrooms", wait: true
    click_button "Create Topping", wait: true

    expect(page).to have_content("Topping successfully created!")
    expect(page).to have_content("Mushrooms")
  end

  it "shows validation errors when creating invalid topping" do
    visit new_topping_path
    fill_in "Name", with: "", wait: true
    click_button "Create Topping", wait: true

    expect(page).to have_content("Name can't be blank")
  end

  it "edits an existing topping" do
    topping = Topping.create!(name: "Onions")

    visit toppings_path
    within("#topping-#{topping.id}") do
      click_link "Edit", wait: true
    end

    fill_in "Name", with: "red onions", wait: true
    click_button "Update Topping", wait: true

    expect(page).to have_content("Topping successfully updated!")
    expect(page).to have_content("Red onions")
  end

  it "deletes a topping upon confirmation" do
    topping = Topping.create!(name: "Remove me")

    visit toppings_path
    within("#topping-#{topping.id}") do
      accept_confirm do
        click_button "Delete", wait: true
      end
    end

    expect(page).to have_content("Topping successfully deleted!")
    expect(page).not_to have_content("Remove me")
  end

  it "does not delete a topping if not confirmed" do
    topping = Topping.create!(name: "Do not remove")

    visit toppings_path
    within("#topping-#{topping.id}") do
      dismiss_confirm do
        click_button "Delete", wait: true
      end
    end

    expect(page).to have_content("Do not remove")
    expect(page).not_to have_content("Topping successfully deleted!")
  end
end
