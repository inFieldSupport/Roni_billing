Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :employees
  resources :clients
  get '/signin', to: 'sessions#new', as:"login"
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#logout', as:"logout"
  # Defines the root path route ("/")
   root "employees#index"
end
