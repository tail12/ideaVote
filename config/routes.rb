Rails.application.routes.draw do

  root 'welcome#index'
  get 'signup' => 'users#new'
  get    'login' => 'sessions#new'
  post   'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :ideas
end
