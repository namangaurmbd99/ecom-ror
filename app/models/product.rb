class Product < ApplicationRecord
  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  has_many_attached :images
  has_many :order_products 

  validate :images_file_types

  private

  def images_file_types
    return unless images.attached?

    images.each do |image|
      if !image.content_type.in?(%('image/jpeg image/jpg image/png'))
        errors.add(:images, 'must be a JPEG, JPG, or PNG')
      end
    end
  end
end
