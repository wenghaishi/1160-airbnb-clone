Rails.application.routes.draw do
  devise_for :users
  root to: "listings#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :listings do
    resources :bookings, only: %i[show new create]
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
