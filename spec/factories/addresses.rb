FactoryBot.define do
    factory :address do
      user
      address { Faker::Address.street_address }
      city { Faker::Address.city }
      state { Faker::Address.state }
      country { Faker::Address.country }
    end
  end
  