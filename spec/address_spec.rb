require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:orders) }
  end

  describe 'validations' do
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:country) }
  end

  describe '#full_address' do
    it 'returns the full address' do
      user = FactoryBot.create(:user)
      address = FactoryBot.create(:address, user: user)
      expected_full_address = "#{address.address}, #{address.city}, #{address.state}, #{address.country}"
      expect(address.full_address).to eq(expected_full_address)
    end
  end
end
