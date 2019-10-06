Rails.application.routes.draw do
  
  get 'users/create'
  get 'users/new'
  root to: 'tasks#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users, only: [:new, :create, :show]
  resources :tasks
end
