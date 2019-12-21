Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/users/potentials', to: 'users#potential_match'
  post '/sign_up', to: 'users#create'
  post '/sign_in', to: 'sessions#create'

  post '/images/upload_url', to: 'images#upload_url'
  post '/images', to: 'images#create'
end
