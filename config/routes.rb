Rails.application.routes.draw do

  root 'welcome#index'
  get 'signup' => 'users#new'
  get    'login' => 'sessions#new'
  post   'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  post 'like/:idea_id' => 'likes#like', as: 'like'
  delete 'unlike/:idea_id' => 'likes#unlike', as: 'unlike'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :ideas
end
