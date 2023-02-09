Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show]
      resources :products, only: [:create, :show] do
        collection do
          get 'my_products'
        end
      end
      resources :sales, only: [:create, :show]
      resources :questions, only: [:create, :show]
    end
  end
end
