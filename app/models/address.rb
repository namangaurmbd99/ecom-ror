# app/models/address.rb
class Address < ApplicationRecord
    belongs_to :user
    has_many :orders
  
    def full_address
      [address, city, state, country].compact.join(', ')
    end
    validates :address, :city, :state, :country, presence: true
  end
  