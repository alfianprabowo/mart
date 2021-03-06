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
  post '/retur/:id/confirmation', to: 'returs#accept', as: 'retur_accept'

  get '/transfer/:id/confirmation', to: 'transfers#confirmation', as: 'transfer_confirmation'
  post '/transfer/:id/confirmation', to: 'transfers#accept', as: 'transfer_accept'

  get 'transfer/:id/sent', to:'transfers#picked', as: 'transfer_picked'
  post 'transfer/:id/sent', to: 'transfers#sent', as: 'transfer_sent'

  get 'transfer/:id/receive', to: 'transfer_item#sent', as: 'transfer_item_sent'
  post 'transfer/:id/receive', to: 'transfer_item#receive', as: 'transfer_item_receive'

  post '/retur/:id/picked', to: 'returs#picked', as: 'retur_picked'
  get '/retur/:id/feedback', to: 'retur_items#feedback', as: 'retur_feedback'
  post '/retur/:id/confirm_feedback', to: 'retur_items#feedback_confirmation', as: 'retur_feedback_confirmation'

  delete '/sign_out', to: 'sessions#destroy'

  resources :items, only: %i[index new create edit update]
  resources :item_cats, only: %i[index new create edit update]
  resources :stocks, only: %i[index edit update]
  resources :users, only: %i[index new create edit update]
  resources :stores, only: %i[index new create edit update]
  resources :suppliers, only: %i[index new create edit update]
  resources :members, only: %i[index new create edit update]
  resources :returs
  resources :transfers
  resources :retur_items, only: %i[index new create edit update]
  resources :transfer_items, only: %i[index new create edit update]
  resources :transaction_types, only: %i[index new create edit update]
  resources :transactions, only: %i[index new create edit update]
  resources :transaction_items, only: %i[index new create edit update]
  resources :cashier, only: %i[index new create edit update]
end
