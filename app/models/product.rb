# app/models/product.rb
class Product < ApplicationRecord
    validates :name, :description, :price, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 0 }

    has_many_attached :images
    has_many :order_products 
  end
  