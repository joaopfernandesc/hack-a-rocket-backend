Rails.application.routes.draw do
  resources :sessions, only: [:create]
  resources :users, only: [:create, :update, :show]
  resources :appointments
  resources :confirm
  resources :paths, only: [:index]
  resources :ratings, only: [:create, :index]
  resources :regular_times
end
