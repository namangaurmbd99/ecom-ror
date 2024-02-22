# app/models/product.rb
class Product < ApplicationRecord
    validates :name, :description, :price, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 0 }

    #Add image attribute to product
    has_one_attached :image
  end
  