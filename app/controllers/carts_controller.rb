class CartsController < ApplicationController

    def show
        @cart = current_user.cart
        @cart_products = @cart.cart_products.includes(:product)
        
        # Calculate total amount
        @total_amount = 0
        @cart_products.each do |item|
          price = item.product.price || 0 # Handle nil price
          quantity = item.quantity || 0 # Handle nil quantity
          @total_amount += price * quantity
        end
      end

      def add_product
        product = Product.find(params[:product_id])
        quantity = params[:quantity].to_i || 1
        current_user.cart.add_product(product, quantity)
        redirect_to cart_path
      end
      
   
    def checkout
      @cart = current_user.cart
      @cart.cart_products.destroy_all
      redirect_to cart_path
    end   
    
    def empty
        current_user.cart.cart_products.destroy_all
        redirect_to cart_path, notice: 'Cart emptied successfully.'
    end
  
    private
  
    def cart_params
      params.require(:cart).permit(:user_id)
    end
  end
  