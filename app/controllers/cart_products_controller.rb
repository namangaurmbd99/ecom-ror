class CartProductsController < ApplicationController
    before_action :set_cart_product, only: [:show, :edit, :update, :destroy]

    def show
      authorize @cart_product # Ensure user is authorized to view cart product
    end
    
    def create
      @cart_product = CartProduct.new(cart_product_params)
      authorize @cart_product # Ensure user is authorized to create cart product
  
      if @cart_product.save
        redirect_to @cart_product.cart, notice: 'Product added to cart successfully.'
      else
        redirect_to @cart_product.cart, alert: 'Failed to add product to cart.'
      end
    end

    def edit
      authorize @cart_product # Ensure user is authorized to edit cart product
    end


    def update
      authorize @cart_product # Ensure user is authorized to update cart product

      if @cart_product.update(cart_product_params)
        redirect_to @cart_product.cart, notice: 'Product quantity updated successfully.'
      else
        redirect_to @cart_product.cart, alert: 'Failed to update product quantity.'
      end
    end
 
    def destroy
      authorize @cart_product # Ensure user is authorized to delete cart product
      @cart_product = CartProduct.find(params[:id])
      @cart_product.destroy
      redirect_to cart_path, notice: 'Product removed from cart successfully.'
    end

    def remove_product
      authorize @cart_product # Ensure user is authorized to delete cart product
      product = Product.find(params[:product_id])
      current_user.cart.products.delete(product)
      redirect_to cart_path
    end

    private
  
    def set_cart_product
      @cart_product = CartProduct.find(params[:id])
    end
  
    def cart_product_params
      params.require(:cart_product).permit(:cart_id, :product_id, :quantity)
    end
  end
  