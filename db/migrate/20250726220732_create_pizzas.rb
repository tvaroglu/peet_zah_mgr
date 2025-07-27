class CreatePizzas < ActiveRecord::Migration[8.0]
  def change
    create_table :pizzas do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end

    add_index :pizzas, :name, unique: true
  end
end
