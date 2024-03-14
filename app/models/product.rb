class Product < ApplicationRecord
  # Validations
  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  # Associations
  has_many_attached :images
  has_many :order_products

  # Custom validation for image file types
  validate :images_file_types

  private

  # Validate image file types
  def images_file_types
    return unless images.attached?

    images.each do |image|
      unless image.content_type.in?(%w(image/jpeg image/jpg image/png))
        errors.add(:images, 'must be a JPEG, JPG, or PNG')
      end
    end
  end
end
