require 'rails_helper'

RSpec.describe Pizza, type: :model do
  subject { Pizza.create!(name: "Test Pizza") }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should have_many(:pizza_toppings).dependent(:destroy) }
  it { should have_many(:toppings).through(:pizza_toppings) }
end
