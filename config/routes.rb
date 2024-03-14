Rails.application.routes.draw do
  get 'checkout/confirm_order'
  get 'home/index'
  #root to product index
  root to: 'products#index'

  # devise_for :users
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }


  resources :addresses
  resources :products
  resource :cart, only: [:show] do
    post 'add_product', on: :member
    delete 'remove_product', on: :member
    post 'checkout', on: :member
    delete 'empty', on: :member
  end
  resources :products do
    post 'add_to_cart', on: :member
  end
  resources :cart_products, only: [:show, :create, :edit, :update, :destroy] do
    delete 'remove_product', on: :member
  end
  resources :checkout, only: [] do
    collection do
      get 'confirm_order', to: 'checkout#confirm_order'
      post 'place_order', to: 'checkout#place_order'
    end
  end

  get 'order_confirmation', to: 'checkout#order_confirmation', as: 'order_confirmation'
  get 'checkout/index', to: 'checkout#index', as: 'checkout_index'
  resources :orders
  resources :order_products
  resources :payments
  resources :orders do
    resources :payments
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end