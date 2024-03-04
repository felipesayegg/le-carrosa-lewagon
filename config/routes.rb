Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"
  resources :cars do
    resources :orders, only: [:new, :create]
  end

  resources :orders, only: [:show, :index]

  get 'my_cars', to: 'cars#my_cars', as: 'my_cars'
  get 'my_orders', to: 'orders#index', as: 'my_orders'



  # get 'cars/:id', to: 'cars#show', as: 'car'

  # post 'cars', to: 'cars#create'
  # patch 'cars/:id', to: 'cars#update'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "cars#index"
end
