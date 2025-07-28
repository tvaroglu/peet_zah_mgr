require 'rails_helper'

RSpec.describe "User management", type: :system do
  it "allows a user to create a new account" do
    visit new_user_path

    fill_in "Username", with: "new_user", wait: true
    fill_in "Password", with: "password", wait: true
    fill_in "Password confirmation", with: "password", wait: true
    select "Manager 👨‍🍳", from: "Employee Type"

    click_button "Sign Up", wait: true

    expect(page).to have_content("Logged in")
  end

  it "shows errors for invalid signup attempt" do
    visit new_user_path
    click_button "Sign Up", wait: true

    expect(page).to have_content("Failed to create account.")
  end

  let!(:user) { User.create!(username: "login_user", password: "password", role: User::ROLE_CHEF) }

  it "allows a valid user to log in" do
    visit login_path

    fill_in "Username", with: "login_user", wait: true
    fill_in "Password", with: "password", wait: true
    click_button "Login", wait: true

    expect(page).to have_content("Logged in")
  end

  it "rejects invalid credentials" do
    visit login_path

    fill_in "Username", with: "login_user", wait: true
    fill_in "Password", with: "wrong", wait: true
    click_button "Login", wait: true

    expect(page).to have_content("Invalid username or password.")
  end

  it "logs out the current user" do
    visit login_path
    fill_in "Username", with: "login_user", wait: true
    fill_in "Password", with: "password", wait: true
    click_button "Login", wait: true

    click_button "Logout", wait: true

    expect(page).to have_button("Login")
  end
end
