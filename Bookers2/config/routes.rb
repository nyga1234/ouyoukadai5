Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get '/search', to: 'search#search'

  resources :users, only: [:show, :edit, :update, :index, :follower, :followed] do
      resource :relationships, only: [:create, :destroy]
      get :follower, :followed
    end
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

end
