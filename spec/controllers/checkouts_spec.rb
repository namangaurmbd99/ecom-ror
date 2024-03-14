require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #confirm_order' do
    it 'returns http success' do
      get :confirm_order
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #place_order' do
    let(:address) { create(:address, user: user) }
    let(:valid_attributes) { attributes_for(:order, address_id: address.id) }

    context 'with valid params' do
      it 'creates a new order' do
        expect {
          post :place_order, params: { order: valid_attributes }
        }.to change(Order, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'does not create the order' do
        post :place_order, params: { order: { address_id: nil } }
        expect(Order.count).to eq(0)
      end
    end
  end

  describe 'GET #order_confirmation' do
    let(:order) { create(:order, user: user) }

    it 'returns http success' do
      get :order_confirmation
      expect(response).to have_http_status(:success)
    end
  
    it 'assigns @order' do
        get :order_confirmation
        expect(assigns(:order)).to eq(order)
    end

    it 'assigns @order_products' do
        get :order_confirmation
        expect(assigns(:order_products)).to eq(order.order_products)
    end

    it 'redirects to root_path if no orders found' do
        user.orders.destroy_all
        get :order_confirmation
        expect(response).to redirect_to(root_path)
    end
    end

  describe 'order_params' do
    it 'permits address_id, payment_method' do
      expect(controller.send(:order_params)).to eq({ 'address_id' => nil, 'payment_method' => nil })
    end
  end
end

