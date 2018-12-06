Rails.application.routes.draw do

  namespace :admin do
      resources :users
      resources :stores

      root to: "users#index"
    end
  root :to => "homes#index"

  resources :registers, only: %i[new create]

  # Clearance
  resource :session, controller: 'sessions', only:  %i[create]
  get '/sign_in', to: 'sessions#new', as: 'sign_in'
  delete '/sign_out', to: 'sessions#destroy'
  #

  resources :items, only: %i[index new create edit update]
  resources :item_cats, only: %i[index new create edit update]
  resources :stocks, only: %i[index edit update]
  resources :users, only: %i[index new create edit update]
  resources :stores, only: %i[index new create edit update]
  resources :members, only: %i[index new create edit update]
  resources :returns, only: %i[index new create edit update]
  resources :return_items, only: %i[index new create edit update]
  resources :transaction_types, only: %i[index new create edit update]
  resources :transactions, only: %i[index new create edit update]

end
