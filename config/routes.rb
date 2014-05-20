Rails.application.routes.draw do

  root 'welcome#index'
  resources :users
  resources :friendships

  delete '/logout', to: 'sessions#destroy'
end
