FactoryBot.define do
    factory :order_product do
      association :order
      association :product
    end
  end
  