class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :add_to_cart]
  before_action :authorize_product, except: [:index, :new, :create]

  def index
    @products = Product.all
  end
  
  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    authorize @product

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  def add_to_cart
    authorize @product, :add_to_cart?
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
  
  def authorize_product
    authorize @product
  end

  def cart
    current_user.cart || current_user.create_cart
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, images: [])
  end
end
