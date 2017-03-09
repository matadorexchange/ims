Rails.application.routes.draw do
  get 'sessions/new'

  get 'market/new'

  get 'position_taking/new'

  get 'member_status/new'

  get 'rates/new'

  get 'members/new'

  get '/login', to: 'sessions#new'

  post '/login',   to: 'sessions#create'

  get '/logout', to: 'sessions#destroy' 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root'pages#home'
  get '/members', to: 'members#index'
  get '/createmember', to: 'members#new'
  post '/members', to: 'members#create'

  get '/users', to: 'users#new'
  post '/users', to: 'users#create'

  get '/editusers', to: 'users#edit'
  post '/editusers', to: 'users#update'
  resources :members
  resources :users
  resources :rates
  
end
