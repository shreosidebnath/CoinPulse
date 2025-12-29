Rails.application.routes.draw do
  devise_for :users
  post 'demo', to: 'sessions#demo', as: :demo
  get 'setup', to: 'application#setup' if Rails.env.production?
  
  root 'dashboard#index'
  
  resources :portfolios do
    resources :holdings, only: [:create, :destroy]
  end
  
  get "up" => "rails/health#show", as: :rails_health_check
end