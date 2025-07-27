class PizzaTopping < ApplicationRecord
  belongs_to :pizza
  belongs_to :topping

  validates :pizza_id, uniqueness: { scope: :topping_id, message: "pizza already has this topping" }
end
