Rails.application.routes.draw do
  resources :tasks do 
    post :complete, on: :member
  end

  resources :task_lists
  resources :events
  
  resources :users do 
    resources :notifications, only: [:index, :destroy], on: :member do
      get :toggle_read, on: :member
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # everybody lands at users
  root to: "users#index"
end
