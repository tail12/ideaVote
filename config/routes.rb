Rails.application.routes.draw do

  resources :comments
  root 'welcome#index'
  get 'signup' => 'users#new'
  get    'login' => 'sessions#new'
  post   'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'new_arrival' => 'ideas#detail'

  resources :users, only: [:index, :show] do
    member do
      get :like_ideas
    end
  end

  resources :ideas do
    member do
      get :liking_users
    end
  end

  post 'like/:idea_id' => 'likes#like', as: 'like'
  delete 'unlike/:idea_id' => 'likes#unlike', as: 'unlike'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :ideas
  resources :relationships, only: [:create, :destroy]
end
