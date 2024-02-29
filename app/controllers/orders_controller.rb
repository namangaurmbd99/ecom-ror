class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :edit, :update, :destroy]
  
    def index
        authorize Order
        @orders = current_user.orders.includes(:order_products)
    end
  
    def show
    end
  
    def new
        authorize Order
        @order = current_user.orders.build
    end
  
    def create
        authorize Order
        @order = current_user.orders.build(order_params)
        if @order.save
            redirect_to @order, notice: 'Order was successfully created.'
        else
            render :new
      end
    end
  
    def edit
    end
  
    def update
        authorize Order
      if @order.update(order_params)
        redirect_to @order, notice: 'Order was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
        authorize Order
      @order.destroy
      redirect_to orders_url, notice: 'Order was successfully destroyed.'
    end
  
    private
  
    def set_order
      @order = current_user.orders.find(params[:id])
    end
  
    private
    def order_params
      params.require(:order).permit(:user_id, :total_amount) # Add other permitted attributes as needed
    end
  end
  