Rails.application.routes.draw do
  resources :session, only: [:new, :create]
end
