require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:addresses).dependent(:destroy) }
    it { should have_one(:cart).dependent(:destroy) }
    it { should have_many(:orders).dependent(:destroy) }
    it { should have_many(:payments).through(:orders).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:role) }

    it do
      should define_enum_for(:role)
        .with_values(admin: 'admin', customer: 'customer')
        .backed_by_column_of_type(:string)
    end

    it { should allow_values('admin', 'customer').for(:role) }
    it { should_not allow_values(nil, '', 'invalid_role').for(:role) }
  end

  describe 'role check methods' do
    let(:admin_user) { FactoryBot.create(:user, role: 'admin') }
    let(:customer_user) { FactoryBot.create(:user, role: 'customer') }

    it 'returns true if user is admin' do
      expect(admin_user.admin?).to eq(true)
      expect(customer_user.admin?).to eq(false)
    end

    it 'returns true if user is customer' do
      expect(customer_user.customer?).to eq(true)
      expect(admin_user.customer?).to eq(false)
    end
  end
end
