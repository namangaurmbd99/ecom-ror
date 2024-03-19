class CheckoutController < ApplicationController
  before_action :set_order, only: [:confirm_order, :place_order, :order_confirmation]

  def confirm_order
    @cart_products = current_user.cart.cart_products.includes(:product)
    @order = current_user.orders.build
  end

  def place_order
    @order = current_user.orders.build(order_params)
    @order.total_amount = 0
    @cart_products = current_user.cart.cart_products.includes(:product)
    
    return redirect_empty_cart if @cart_products.empty?
    
    if @order.save
      update_order_products
      redirect_after_order_success
    else
      flash[:alert] = 'Failed to place order.'
      render :confirm_order
    end
  end
  
  def order_confirmation
    if @order.nil?
      flash[:alert] = "No orders found."
      redirect_to root_path
    else
      @order_products = @order.order_products.includes(:product)
    end
  end
  
  private
  
  def set_order
    @order = current_user.orders.last
  end
  
  def order_params
    params.require(:order).permit(:address_id, :payment_method)
  end
  
  def redirect_empty_cart
    flash[:alert] = 'Your cart is empty. Please add items to your cart before placing an order.'
    redirect_to cart_path
  end
  
  def update_order_products
    @cart_products.each do |cart_product|
      order_product = @order.order_products.build(
        product: cart_product.product,
        quantity: cart_product.quantity,
        amount: cart_product.product.price * cart_product.quantity
      )
      @order.total_amount += order_product.amount
    end
    @order.update(payment_method: order_params[:payment_method])
    @order.save
    current_user.cart.cart_products.destroy_all
  end
  
  def redirect_after_order_success
    redirect_to order_confirmation_path(order_id: @order.id), notice: 'Order placed successfully!'
  end
end
