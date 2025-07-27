class AddUniquenessConstraints < ActiveRecord::Migration[7.0]
  def change
    # Unique index on pizza names (case-insensitive)
    add_index :pizzas, 'lower(name)', unique: true, name: 'index_pizzas_on_lower_name'

    # Unique index on topping names (case-insensitive)
    add_index :toppings, 'lower(name)', unique: true, name: 'index_toppings_on_lower_name'

    # Ensure no duplicate toppings on a pizza
    add_index :pizza_toppings, [ :pizza_id, :topping_id ], unique: true, name: 'index_pizza_toppings_on_pizza_and_topping'
  end
end
