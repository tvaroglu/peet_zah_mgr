require 'rails_helper'

RSpec.describe Pizza, type: :model do
  let!(:cheese) { Topping.create!(name: "Cheese") }

  subject do
    Pizza.create!(name: "Test Pizza", toppings: [ cheese ])
  end

  it { should validate_presence_of(:name) }

  it "validates case-insensitive uniqueness of name" do
    Pizza.create!(name: "Unique Pizza", toppings: [ cheese ])
    dup = Pizza.new(name: "unique pizza", toppings: [ cheese ])
    expect(dup.valid?).to be false
    expect(dup.errors[:name]).to include("has already been taken")
  end

  it { should have_many(:pizza_toppings).dependent(:destroy) }
  it { should have_many(:toppings).through(:pizza_toppings) }

  it "capitalizes name before saving" do
    pizza = Pizza.create!(name: "test pizza", toppings: [ cheese ])
    expect(pizza.name).to eq("Test Pizza")
  end

  it "requires at least one topping" do
    pizza = Pizza.new(name: "No Toppings")
    expect(pizza.valid?).to be false
    expect(pizza.errors[:toppings]).to include("must include at least one topping")
  end

  it "prevents duplicate topping sets regardless of name" do
    Pizza.create!(name: "Combo Pizza", toppings: [ cheese ])
    dup = Pizza.new(name: "Another Name", toppings: [ cheese ])
    expect(dup.valid?).to be false
    expect(dup.errors[:base]).to include("A pizza with the same set of toppings already exists")
  end
end
