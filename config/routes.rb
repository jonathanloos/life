Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  
  # open /mail in dev mode to debug outgoing mail
  mount LetterOpenerWeb::Engine, at: "/mail" if Rails.env.development?

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
