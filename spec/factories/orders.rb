FactoryBot.define do
    factory :order do
      association :user
      association :address
      total_amount { 100 } # Default total amount
      payment_method { "Credit Card" } # Default payment method
  
      # Create associated order_products
      transient do
        order_products_count { 1 }
      end
  
      after(:create) do |order, evaluator|
        create_list(:order_product, evaluator.order_products_count, order: order)
      end
    end
  end
  