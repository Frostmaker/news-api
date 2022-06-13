Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end

  namespace :api do
    resources :posts do
      resources :comments
    end
  end

  root "posts#index"
end
