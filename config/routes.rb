Rails.application.routes.draw do
  root "quizzes#index"
  resources :session, only: [:new, :create, :destroy]
  resources :quizzes, only: [:index]
end
