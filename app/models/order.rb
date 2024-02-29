class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_products
  has_one :payment

  attribute :total_amount
  attribute :payment_method

  # Calculate the total amount based on order products
  def calculate_total_amount
    self.total_amount = order_products.sum(&:amount)
  end
end
