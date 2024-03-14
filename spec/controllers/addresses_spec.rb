require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:user) { create(:user) } # Assuming you have a user factory set up
  let(:address) { create(:address, user: user) } # Assuming you have an address factory set up

  describe "GET #index" do
    it "returns a success response" do
      sign_in user
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      sign_in user
      get :show, params: { id: address.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      sign_in user
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      sign_in user
      get :edit, params: { id: address.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Address" do
        sign_in user
        expect {
          post :create, params: { address: attributes_for(:address) }
        }.to change(Address, :count).by(1)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        sign_in user
        post :create, params: { address: attributes_for(:address, address: nil) }
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { address: "New Address" }
      }

      it "updates the requested address" do
        sign_in user
        put :update, params: { id: address.to_param, address: new_attributes }
        address.reload
        expect(address.address).to eq("New Address")
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        sign_in user
        put :update, params: { id: address.to_param, address: attributes_for(:address, address: nil) }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested address" do
      sign_in user
      address = create(:address, user: user)
      expect {
        delete :destroy, params: { id: address.to_param }
      }.to change(Address, :count).by(-1)
    end
  end

  describe "address_params" do
    it "permits address, city, state, and country" do
      sign_in user
      expect {
        post :create, params: { address: attributes_for(:address) }
      }.to change(Address, :count).by(1)
    end
  end

end
