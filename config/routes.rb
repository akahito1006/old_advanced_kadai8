Rails.application.routes.draw do

  devise_for :users
  root 'homes#top'
  get "home/about" => 'homes#about'
  
  get "follow" => 'relationships#follow'
  get "follower" => 'relationships#follower'
  
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
  end
  
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end