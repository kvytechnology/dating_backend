Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/users_radar', to: 'users#radar'
  get '/matches', to: 'users#matches'
  post '/users/reject', to: 'users#reject'
  post '/users/potentials', to: 'users#potential_match'
  post '/sign_up', to: 'users#create'
  post '/sign_in', to: 'sessions#create'

  post '/images/upload_url', to: 'images#upload_url'
  post '/images', to: 'images#create'
end
