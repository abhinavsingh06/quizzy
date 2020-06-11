Rails.application.routes.draw do
  root "quizzes#index"
  resource :sessions, only: [:new, :create, :destroy]
  resources :quizzes
end
