Rails.application.routes.draw do
  root to: 'quizzes#new'

  #問題作成
  resources :quizzes do
    resources :questions do
      resources :choices do
        member do
          post 'set_correct_answer'
        end
      end
    end

  #問題回答
    resources :challengers do
      resources :questions do
        resources :choices do
          member do
            post 'judgement'
          end
        end
      end
    end
  end
end
