FactoryBot.define do
    factory :product do
      name { "Test Product" }
      description { "Test Description" }
      price { 10 }
  
      # Add images attachment
      transient do
        with_images { false }
      end
  
      after(:build) do |product, evaluator|
        if evaluator.with_images
          product.images.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'test_image.jpg')), filename: 'test_image.jpg', content_type: 'image/jpeg')
        end
      end
    end
  end
  