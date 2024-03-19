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
    save_order('Order was successfully created.', :new)
  end

  def edit
  end

  def update
    authorize Order
    save_order('Order was successfully updated.', :edit)
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

  def order_params
    params.require(:order).permit(:user_id, :total_amount)
  end

  def save_order(success_message, render_action)
    if @order.update(order_params)
      redirect_to @order, notice: success_message
    else
      render render_action
    end
  end
end
