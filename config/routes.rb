Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/sign_up', to: 'users#create'
  post '/sign_in', to: 'sessions#create'
end
