require 'rails_helper'

RSpec.describe Topping, type: :model do
  subject { Topping.create!(name: "Cheese") }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should have_many(:pizza_toppings).dependent(:restrict_with_error) }
  it { should have_many(:pizzas).through(:pizza_toppings) }

  it "normalizes name capitalization" do
    t = Topping.create!(name: "  pepperoni  ")
    expect(t.name).to eq("Pepperoni")
  end

  it "prevents deletion if used on a pizza" do
    pizza = Pizza.create!(name: "Test Pizza", toppings: [ subject ])
    expect(subject.destroy).to be false
    expect(subject.errors[:base]).to include("Cannot delete record because dependent pizza toppings exist")
  end
end
