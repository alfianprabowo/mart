Rails.application.routes.draw do

  namespace :admin do
      resources :items
      resources :item_cats
      resources :users

      root to: "items#index"
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
end
