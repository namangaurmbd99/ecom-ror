FactoryBot.define do
    factory :user do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      phone_number { Faker::PhoneNumber.phone_number }
      password { 'password' }
      role { 'customer' } # Default role is set to 'customer'
    end
  end
  