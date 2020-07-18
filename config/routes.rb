Rails.application.routes.draw do
  resources :consultant_sessions, only: [:create]
end
