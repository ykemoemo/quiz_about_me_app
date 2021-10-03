Rails.application.routes.draw do
  root to: 'quizzes#new'

  # サービス概要
  resources :helps, only: [:index]

  # 問題作成
  resources :quizzes, except: [:edit, :update, :destroy] do
    resources :questions, except: [:new, :edit, :update] do
      resources :choices, only: [] do
        member do
          post 'set_correct_answer'
        end
      end
    end

    # 問題回答
    resources :challengers, only: [:show, :new, :create] do
      resources :questions, except: [:new, :edit, :update] do
        resources :choices, only: [] do
          member do
            post 'judgement'
          end
        end
      end
    end
  end
end
