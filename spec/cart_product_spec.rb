require 'rails_helper'

RSpec.describe CartProduct, type: :model do
  describe 'associations' do
    it { should belong_to(:cart) }
    it { should belong_to(:product) }
  end

  describe 'validations' do
    it { should validate_presence_of(:cart_id) }
    it { should validate_uniqueness_of(:cart_id).scoped_to(:product_id) }
  end

  describe '#total_amount' do
    let(:cart_product) { build(:cart_product, product: build(:product, price: 10), quantity: 2) }

    it 'calculates the total amount correctly' do
      expect(cart_product.total_amount).to eq(20)
    end
  end
end
