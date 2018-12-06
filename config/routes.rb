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
  post 'retur/:id/picked', to: 'returs#picked', as: 'retur_picked'
  get 'retur/:id/feedback', to: 'retur_items#feedback', as: 'retur_feedback'
  post 'retur/:id/confirm_feedback', to: 'retur_items#feedback_confirmation', as: 'retur_feedback_confirmation'
  delete '/sign_out', to: 'sessions#destroy'
  #

  resources :items, only: %i[index new create edit update]
  resources :item_cats, only: %i[index new create edit update]
  resources :stocks, only: %i[index edit update]
  resources :users, only: %i[index new create edit update]
  resources :stores, only: %i[index new create edit update]
  resources :suppliers, only: %i[index new create edit update]
  resources :members, only: %i[index new create edit update]
<<<<<<< HEAD
  resources :returns, only: %i[index new create edit update]
  resources :return_items, only: %i[index new create edit update]
  resources :transaction_types, only: %i[index new create edit update]
  resources :transactions, only: %i[index new create edit update]
=======
  resources :returs
  resources :transfers
  resources :retur_items, only: %i[index new create edit update]
  resources :transfer_items, only: %i[index new create edit update]
>>>>>>> 7d2d1257a415f0ed047c729d6fd1364db893cd8e

end
