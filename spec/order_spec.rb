require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:address) }
    it { should have_many(:order_products) }
    it { should have_one(:payment) }
  end

  describe 'attributes' do
    it { should respond_to(:total_amount) }
    it { should respond_to(:payment_method) }
  end

  describe '#calculate_total_amount' do
    it 'calculates the total amount based on order products' do
      order = create(:order)
      order_product1 = create(:order_product, order: order, amount: 50)
      order_product2 = create(:order_product, order: order, amount: 75)

      order.calculate_total_amount

      expect(order.total_amount).to eq(125)
    end
  end
end
