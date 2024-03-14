# spec/controllers/carts_controller_spec.rb
require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product) }

  before do
    sign_in user
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #add_product' do
    it 'adds product to cart' do
      post :add_product, params: { product_id: product.id, quantity: 1 }
      expect(response).to redirect_to(cart_path)
    end
  end

  describe 'POST #checkout' do
    it 'clears the cart and redirects to cart page' do
      post :checkout
      expect(user.cart.cart_products).to be_empty
      expect(response).to redirect_to(cart_path)
    end
  end

  describe 'POST #empty' do
    it 'empties the cart and redirects to cart page' do
      post :empty
      expect(user.cart.cart_products).to be_empty
      expect(response).to redirect_to(cart_path)
    end
  end

    describe 'POST #add_product' do
        it 'adds product to cart' do
        post :add_product, params: { product_id: product.id, quantity: 1 }
        expect(response).to redirect_to(cart_path)
        end
    end

    describe 'POST #checkout' do
        it 'clears the cart and redirects to cart page' do
        post :checkout
        expect(user.cart.cart_products).to be_empty
        expect(response).to redirect_to(cart_path)
        end
    end

    describe 'POST #empty' do
        it 'empties the cart and redirects to cart page' do
        post :empty
        expect(user.cart.cart_products).to be_empty
        expect(response).to redirect_to(cart_path)
        end
    end

    describe 'cart_params' do
        it 'permits user_id' do
        expect(controller.send(:cart_params)).to eq({ 'user_id' => nil })
        end
    end
end

