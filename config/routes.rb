Rails.application.routes.draw do

  root 'welcome#index'
  resources :users
  resources :friendships
  resources :login

  resource :session, only: [:destroy, :create]
end
