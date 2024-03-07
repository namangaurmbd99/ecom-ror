require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:cart_products).dependent(:destroy) }
    it { should have_many(:products).through(:cart_products) }
  end

  describe '#add_product' do
    let(:user) { create(:user) }
    let(:product) { create(:product) }
    let(:cart) { create(:cart, user: user) }

    context 'when the product is already in the cart' do
      before do
        create(:cart_product, cart: cart, product: product, quantity: 2)
      end

      it 'increments the quantity of the existing product' do
        cart.add_product(product, 3)
        cart_product = cart.cart_products.find_by(product_id: product.id)
        expect(cart_product.quantity).to eq(5) # 2 + 3
      end
    end

    context 'when the product is not in the cart' do
      it 'adds the product with the specified quantity' do
        cart.add_product(product, 3)
        cart_product = cart.cart_products.find_by(product_id: product.id)
        expect(cart_product.quantity).to eq(3)
      end
    end
  end
end
