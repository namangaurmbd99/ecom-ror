require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    
    it 'validates images file types' do
      product = Product.new(name: 'Test Product', description: 'Test Description', price: 10)
      product.images.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'test_image.jpg')), filename: 'test_image.jpg', content_type: 'image/jpeg')
      expect(product).to be_valid
      
      product.images.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'test_image.txt')), filename: 'test_image.txt', content_type: 'text/plain')
      expect(product).to_not be_valid
      expect(product.errors[:images]).to include('must be a JPEG, JPG, or PNG')
    end
  end

  describe 'associations' do
    it { should have_many_attached(:images) }
    it { should have_many(:order_products) }
  end
end
