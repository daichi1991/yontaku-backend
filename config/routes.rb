Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show] do
        collection do
          get 'current_user_infrmation'
        end
      end
      resources :accounts, only: [:create, :show] do
        collection do
          get 'my_accounts'
        end
      end
      resources :products, only: [:create, :update, :show] do
        collection do
          get 'search'
          get 'search_by_subject'
          get 'my_products'
        end
      end
      resources :sales, only: [:create, :show]
      resources :questions, only: [:create, :show]
      resources :answers, only: [:create, :show]
      resources :studies, only: [:create, :show] do
        collection do
          post 'create_study_detail'
        end
        member do
          get 'result'
          get 'memory_score'
          get 'select_questions'
        end
      end
      resources :study_details, only: [:show]
      resources :carts, only: [:create] do
        collection do
          get 'current_user_cart'
        end
      end
      resources :orders, only: [:create]
      resources :tags, only: [:create]
      resources :product_tags, only: [:create]
      resources :subjects, only: [:index, :create, :update]
    end
  end
end
