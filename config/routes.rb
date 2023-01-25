# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :employees
  resources :clients
  resources :bills
  get '/signin', to: 'sessions#new', as: 'login'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#logout', as: 'logout'
  # Defines the root path route ("/")
  root 'clients#index'
  resources :users, only: :update
  resources :standards, only: :update
  post :send_bill_mail, to: 'bills#send_bill_mail', as: :send_bill_mail
end
