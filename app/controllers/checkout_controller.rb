class CheckoutController < ApplicationController
  def confirm_order
    puts "Confirming order11111111" # Debugging output
    @cart_products = current_user.cart.cart_products.includes(:product)
    @order = current_user.orders.build
  end

  def place_order
    puts "Placing order111111" # Debugging output
    @order = current_user.orders.build(order_params)
    puts "Order before saving: #{@order}" # Debugging output
    puts "Order errors: #{@order.errors.full_messages}" if @order.invalid? # Debugging output
    @order.total_amount = 0
    @cart_products = current_user.cart.cart_products.includes(:product)
    
    if @cart_products.empty?
      flash[:alert] = 'Your cart is empty. Please add items to your cart before placing an order.'
      redirect_to cart_path
      return
    end
    
    if @order.save
      @cart_products.each do |cart_product|
        order_product = @order.order_products.build(
          product: cart_product.product,
          quantity: cart_product.quantity,
          amount: cart_product.product.price * cart_product.quantity
        )
        puts "Created order product: #{order_product.inspect}" # Debugging output
        @order.total_amount += order_product.amount
      end
      
      # Assign payment_method to the order
      @order.update(payment_method: order_params[:payment_method])
      
      @order.save # Save the order again to update the total_amount
      current_user.cart.cart_products.destroy_all
      redirect_to order_confirmation_path(order_id: @order.id), notice: 'Order placed successfully!'
    else
      flash[:alert] = 'Failed to place order.'
      render :confirm_order
    end
  end
  
  
  def order_confirmation
    @order = current_user.orders.last
    if @order.nil?
      flash[:alert] = "No orders found."
      redirect_to root_path
    else
      @order_products = @order.order_products.includes(:product)
    end
  end
  
  private
  
  def order_params
    params.require(:order).permit(:address_id, :payment_method)
  end
  
   
end
