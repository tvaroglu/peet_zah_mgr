require 'rails_helper'

RSpec.describe PizzaTopping, type: :model do
  it { should belong_to(:pizza) }
  it { should belong_to(:topping) }

  it "prevents duplicate pizza + topping combos" do
    pizza = Pizza.create!(name: "Test Pizza")
    topping = Topping.create!(name: "Cheese")
    PizzaTopping.create!(pizza: pizza, topping: topping)

    dup = PizzaTopping.new(pizza: pizza, topping: topping)
    expect(dup.valid?).to be false
  end
end
