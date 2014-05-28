Rails.application.routes.draw do

  root 'welcome#index'
  resources :users
  get 'confirm/:id', to: 'users#confirm', as: :confirmation
  get 'login/confirmation/:id', to: 'login#confirmation'
  get 'login/confirmation/send/:id', to: 'users#send_confirmation_email', as: :resend_confirmation
  resources :friendships
  resources :login

  resource :session, only: [:destroy, :create]
end
