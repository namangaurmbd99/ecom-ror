# class PaymentsController < ApplicationController
#     before_action :set_order, only: [:index, :new, :create]
#     before_action :authorize_payment, only: [:new, :create]
  
#     def index
#         @payments = @order.payments
#     end


#     def new
#         authorize Payment
#       @payment = @order.payments.build
#     end
  
#     def create
#         authorize Payment
#       @payment = @order.payments.build(payment_params)
  
#       if @payment.save
#         redirect_to @order, notice: 'Payment was successfully created.'
#       else
#         render :new
#       end
#     end
  
#     private
  
#     def set_order
#       @order = Order.find_by(id: params[:order_id])
#       unless @order
#         flash[:alert] = 'Order not found.'
#         redirect_to root_path
#       end
#     end
    
  
#     private
#     def payment_params
#       params.require(:payment).permit(:amount, :payment_date)
#     end
#   end
  


class PaymentsController < ApplicationController
  before_action :set_order, only: [:index, :new, :create]
  before_action :authorize_payment, only: [:new, :create]

  def index
    @payments = @order.payments
  end

  def new
    authorize Payment
    @payment = @order.payments.build
  end

  def create
    authorize Payment
    @payment = @order.payments.build(payment_params)

    if @payment.save
      redirect_to @order, notice: 'Payment was successfully created.'
    else
      render :new
    end
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :payment_date)
  end
end
