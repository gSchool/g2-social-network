Rails.application.routes.draw do

  root 'welcome#index'
  resources :users, except: [:new, :create] do
    resources :posts
  end
  get '/registrations/new', to: 'registrations#new'
  post '/users', to: 'registrations#create'
  get '/confirm/:id', to: 'confirmations#update', as: :confirmation
  get '/confirmations/confirmation/:id', to: 'confirmations#unconfirmed_registration'
  get '/confirmations/confirmation/send/:id', to: 'confirmations#send_confirmation_email', as: :resend_confirmation
  get '/confirmations', to: 'sessions#new'
  get '/login', to: 'sessions#new'
  get '/confirm-friendships/:friend_id/:requestor_id', to: 'confirmations#confirm_friendships', as: :confirm_friendships

  resources :friendships
  resource :sessions
end
