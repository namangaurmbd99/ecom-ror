# db/migrate/YYYYMMDDHHMMSS_create_orders.rb
class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :address, null: false, foreign_key: true
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
