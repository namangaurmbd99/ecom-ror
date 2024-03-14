# app/models/address.rb
class Address < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :orders

  # Validations
  validates :address, :city, :state, :country, presence: true

  # Methods
  def full_address
    [address, city, state, country].compact.join(', ')
  end
end
