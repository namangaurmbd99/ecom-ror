# db/migrate/YYYYMMDDHHMMSS_create_order_products.rb
class CreateOrderProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :order_products do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :amount, precision: 10, scale: 2
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
