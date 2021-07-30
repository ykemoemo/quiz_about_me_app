Rails.application.routes.draw do
  root to: 'quizzes#top'
  resources :quizzes
end
