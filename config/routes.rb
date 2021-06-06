Rails.application.routes.draw do
  resources :transactions
  resources :groups
  devise_for :users
  root 'transactions#index'
  get '/group-transactions', to: 'transactions#group_transactions'
  get '/statistics', to: 'transactions#stats'
  get '/external-transactions', to: 'transactions#external_transactions'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
