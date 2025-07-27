seed_pwd = ENV.fetch("DEFAULT_SEED_PASSWORD", "tmpforlocaldev")

User.destroy_all
Pizza.destroy_all
Topping.destroy_all
PizzaTopping.destroy_all

User.find_or_create_by!(username: "Seed Manager") do |u|
  u.password = seed_pwd
  u.role = User::ROLE_MANAGER
end

User.find_or_create_by!(username: "Seed Chef") do |u|
  u.password = seed_pwd
  u.role = User::ROLE_CHEF
end

mushroom = Topping.create!(name: "Mushroom")
onion = Topping.create!(name: "Onion")
cheese = Topping.create!(name: "Cheese")
pepperoni = Topping.create!(name: "Pepperoni")

# Associate toppings during pizza creation:
marg = Pizza.create!(
  name: "Margherita",
  description: "Classic cheese pizza",
  toppings: [ cheese ]
)

pep = Pizza.create!(
  name: "Pepperoni",
  description: "Cheese with spicy pepperoni",
  toppings: [ cheese, pepperoni ]
)

puts "DB seed complete: #{User.count} users, #{Pizza.count} pizzas, and #{Topping.count} toppings."
