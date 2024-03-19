require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:user) { create(:user) }

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
    let(:address) { create(:address, user: user) }

    it 'returns http success' do
      get :show, params: { id: address.id }
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
    let(:valid_attributes) { attributes_for(:address) }

    context 'with valid params' do
      it 'creates a new address' do
        expect {
          post :create, params: { address: valid_attributes }
        }.to change(Address, :count).by(1)
      end
    end

    describe 'EDIT #update' do
        let(:address) { create(:address, user: user) }
        let(:new_attributes) { attributes_for(:address) }
    
        context 'with valid params' do
            it 'updates the requested address' do
            put :update, params: { id: address.id, address: new_attributes }
            address.reload
            expect(address.address).to eq(new_attributes[:address])
            end
        end
        end
  end
end
