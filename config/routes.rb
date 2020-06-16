Rails.application.routes.draw do
  root "quizzes#index"

  resource :sessions, only: [:new, :create, :destroy]

  resources :quizzes do
    resources :questions, only: [:new, :create, :edit, :update, :destroy]
  end

  resource :quizzes, only: [] do
    resources :publish, controller: 'quizzes/publish', only: :update
  end
end
