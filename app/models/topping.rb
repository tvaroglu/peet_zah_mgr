class Topping < ApplicationRecord
  has_many :pizza_toppings, dependent: :destroy
  has_many :pizzas, through: :pizza_toppings

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
