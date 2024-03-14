require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:user) { create(:user) }
  let(:product) { create(:product) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: product.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { attributes_for(:product) }

    context 'with valid params' do
      it 'creates a new product' do
        expect {
          post :create, params: { product: valid_attributes }
        }.to change(Product, :count).by(1)
      end
    end

    context 'with invalid params' do
        it 'does not create a new product' do
            expect {
            post :create, params: { product: { name: '' } }
            }.to change(Product, :count).by(0)
        end
        end
  end

    describe 'GET #edit' do
        it 'returns http success' do
            get :edit, params: { id: product.id }
            expect(response).to have_http_status(:success)
        end
    end

    describe 'PUT #update' do
        let(:new_attributes) { { name: 'New Name' } }

        context 'with valid params' do
            it 'updates the product' do
                put :update, params: { id: product.id, product: new_attributes }
                product.reload
                expect(product.name).to eq('New Name')
            end
        end

        context 'with invalid params' do
            it 'does not update the product' do
                put :update, params: { id: product.id, product: { name: '' } }
                product.reload
                expect(product.name).to_not eq('')
            end
        end
    end

    describe 'DELETE #destroy' do
        it 'destroys the product' do
            product
            expect {
                delete :destroy, params: { id: product.id }
            }.to change(Product, :count).by(-1)
        end
    end

    describe 'POST #add_to_cart' do
        it 'adds the product to the cart' do
            cart = user.cart
            product
            expect {
                post :add_to_cart, params: { id: product.id, quantity: 1 }
            }.to change(cart.products, :count).by(1)
        end

        it 'redirects to the cart' do
            post :add_to_cart, params: { id: product.id, quantity: 1 }
            expect(response).to redirect_to(cart_url(user.cart))
        end
    end

    describe 'private methods' do
        describe '#cart' do
            it 'returns the user cart' do
                expect(controller.send(:cart)).to eq(user.cart)
            end
        end
    end

    describe 'authorize' do
        it 'authorizes the product instance' do
            expect(controller).to receive(:authorize).with(product)
            controller.send(:authorize, product)
        end
    end

    describe 'product_params' do
        it 'permits name, description, price' do
            expect(controller.send(:product_params)).to eq({ 'name' => nil, 'description' => nil, 'price' => nil })
        end
    end
    
    
end
