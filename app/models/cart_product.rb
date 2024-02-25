# app/models/cart_product.rb
class CartProduct < ApplicationRecord
  before_create :set_quantity
  belongs_to :cart
  belongs_to :product
  
  validates :cart_id, presence: true, uniqueness: { scope: :product_id }
  
  def total_amount
    
    quantity * product.price
  end

  def set_quantity
    quantity = quantity || 1
  end
end

