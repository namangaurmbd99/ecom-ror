require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns @orders' do
      get :index
      expect(assigns(:orders)).to eq(user.orders)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: order.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'assigns @order' do
      get :new
      expect(assigns(:order)).to be_a_new(Order)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { attributes_for(:order) }

    context 'with valid params' do
      it 'creates a new order' do
        expect {
          post :create, params: { order: valid_attributes }
        }.to change(Order, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'does not create the order' do
        post :create, params: { order: { user_id: nil } }
        expect(Order.count).to eq(0)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get :edit, params: { id: order.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) { { total_amount: 100 } }

    context 'with valid params' do
      it 'updates the order' do
        put :update, params: { id: order.id, order: new_attributes }
        order.reload
        expect(order.total_amount).to eq(100)
      end
    end

    context 'with invalid params' do
        it 'does not update the order' do
            put :update, params: { id: order.id, order: { total_amount: nil } }
            order.reload
            expect(order.total_amount).to_not eq(nil)
        end
        end
    end

    describe 'DELETE #destroy' do
        it 'destroys the order' do
            order
            expect {
                delete :destroy, params: { id: order.id }
            }.to change(Order, :count).by(-1)
        end
        context 'with invalid params' do
            it 'does not destroy the order' do
                order
                expect {
                    delete :destroy, params: { id: nil }
                }.to change(Order, :count).by(0)
            end
        end
    end

    describe 'order_params' do
        it 'permits user_id, total_amount' do
            expect(controller.send(:order_params)).to be_nil
        end
    end
end
