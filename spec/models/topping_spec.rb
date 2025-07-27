require 'rails_helper'

RSpec.describe Topping, type: :model do
  subject { Topping.create!(name: "Cheese") }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should have_many(:pizza_toppings).dependent(:destroy) }
  it { should have_many(:pizzas).through(:pizza_toppings) }
end
