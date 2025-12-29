Rails.application.routes.draw do
  get 'sessions/demo'
  devise_for :users
  post 'demo', to: 'sessions#demo', as: :demo
  
  root 'dashboard#index'
  
  resources :portfolios do
    resources :holdings, only: [:create, :destroy]
  end
  
  get "up" => "rails/health#show", as: :rails_health_check
end