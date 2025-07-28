require 'rails_helper'

RSpec.describe PizzaTopping, type: :model do
  let!(:topping) { Topping.create!(name: "Cheese") }
  let!(:pizza)   { Pizza.create!(name: "Test Pizza", toppings: [ topping ]) }

  it { should belong_to(:pizza) }
  it { should belong_to(:topping) }

  it "prevents duplicate pizza + topping combos" do
    dup = PizzaTopping.new(pizza: pizza, topping: topping)
    expect(dup.valid?).to be false
    expect(dup.errors[:pizza_id]).to include("pizza already has this topping")
  end
end
