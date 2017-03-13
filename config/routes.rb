Rails.application.routes.draw do


  get 'user_settlement_summaries/new'

  get 'settlement_summaries/new'

  get 'settlements/new'

  get 'agent_commissions/new'

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

  get '/master_agents', to: 'master_agents#new'
  post '/master_agents', to: 'master_agents#create'
  
  get '/settlements', to: 'settlements#new'
  resources :settlements do
  	collection { post :import }
  end
end
