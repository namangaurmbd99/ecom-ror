class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_products, dependent: :destroy
  has_many :products, through: :cart_products

  def add_product(product, quantity)
    cart_product = cart_products.find_by(product_id: product.id)
    if cart_product
      cart_product.quantity += quantity
      cart_product.save
    else
      cart_products.create(product: product, quantity: quantity)
    end
  end
end
