class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :add_product, :checkout, :empty]

  def show
    @cart_products = @cart.cart_products.includes(:product)
    @total_amount = calculate_total_amount(@cart_products)
  end

  def add_product
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i || 1
    @cart.add_product(product, quantity)
    redirect_to cart_path
  end

  def checkout
    @cart.cart_products.destroy_all
    redirect_to cart_path
  end

  def empty
    @cart.cart_products.destroy_all
    redirect_to cart_path, notice: 'Cart emptied successfully.'
  end

  private

  def set_cart
    @cart = current_user.cart
  end

  def calculate_total_amount(cart_products)
    total_amount = 0
    cart_products.each do |item|
      price = item.product.price || 0
      quantity = item.quantity || 0
      total_amount += price * quantity
    end
    total_amount
  end
end
