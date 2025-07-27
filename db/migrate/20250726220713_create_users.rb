class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.integer :role, null: false, default: 0  # 0 = chef, 1 = manager

      t.timestamps
    end

    add_index :users, :username, unique: true
  end
end
