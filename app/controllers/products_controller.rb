class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :add_to_cart]
  
  def index
    @products = Product.all
  end
  
  def new
    @product = Product.new
    authorize @product # Authorize the product instance
  end

  def create
    @product = Product.new(product_params)
    authorize @product # Authorize the product instance
    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
    authorize @product
  end

  def update
    authorize @product

    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @product

    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  # def add_to_cart
  #   authorize @product, :add_to_cart?  # Authorize the product instance for 'add_to_cart' action
  #   @product = Product.find(params[:id])
  #   cart_product = CartProduct.where(cart: cart, product: @product).new(quantity: params[:quantity] || 1)
  #   cart_product.save
  #   redirect_to cart_url(@cart), notice: 'Product added to cart successfully.'
  # end
  
  # private

  # def cart
  #   @cart = current_user.cart || current_user.create_cart
  # end

  # def add_to_cart
  #   authorize @product, :add_to_cart?  # Authorize the product instance for 'add_to_cart' action
  #   @product = Product.find(params[:id])
  #   @cart = cart
  #   quantity = params[:quantity].to_i || 1
  #   cart_product = CartProduct.where(cart: @cart, product: @product).new(quantity: params[:quantity] || 1)
  #   cart_product.save
  #   redirect_to cart_url(@cart), notice: 'Product added to cart successfully.'
  # end

  def add_to_cart
    authorize @product, :add_to_cart?  # Authorize the product instance for 'add_to_cart' action
    @product = Product.find(params[:id])
    @cart = cart
    quantity = params[:quantity].to_i
    cart_product = CartProduct.where(cart: @cart, product: @product).new(quantity: quantity)
    if cart_product.save
      redirect_to cart_url(@cart), notice: 'Product added to cart successfully.'
    else
      redirect_to @product, alert: 'Failed to add product to cart.'
    end
  end

  private
  
  def cart
    current_user.cart || current_user.create_cart
  end
  

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :image[])
  end
end
