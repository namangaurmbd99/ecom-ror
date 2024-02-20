# app/models/address.rb
class Address < ApplicationRecord
    belongs_to :user
  
    validates :address, :city, :state, :country, presence: true
  end
  