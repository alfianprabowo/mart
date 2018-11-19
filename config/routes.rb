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
  get '/retur/:id/confirmation', to: 'returs#confirmation', as: 'retur_confirmation'
  post 'retur/:id/confirmation', to: 'returs#accept', as: 'retur_accept'
  delete '/sign_out', to: 'sessions#destroy'
  #

  resources :items, only: %i[index new create edit update]
  resources :item_cats, only: %i[index new create edit update]
  resources :stocks, only: %i[index edit update]
  resources :users, only: %i[index new create edit update]
  resources :stores, only: %i[index new create edit update]
  resources :members, only: %i[index new create edit update]
  resources :returs, only: %i[index new create edit update]
  resources :retur_items, only: %i[index new create edit update]

end
