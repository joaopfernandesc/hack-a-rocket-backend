Rails.application.routes.draw do
  resources :sessions, only: [:create]
  resources :users
  resources :appointments
  resources :confirm
end
