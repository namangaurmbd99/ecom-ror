FactoryBot.define do
    factory :cart do
      association :user
  
      # Create associated cart_products
      transient do
        cart_products_count { 1 }
      end
  
      after(:create) do |cart, evaluator|
        create_list(:cart_product, evaluator.cart_products_count, cart: cart)
      end
    end
  end
  