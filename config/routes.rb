Rails.application.routes.draw do
  root to: 'quizzes#new'
  resources :quizzes do
    resources :questions
    resources :challengers
  end
end
