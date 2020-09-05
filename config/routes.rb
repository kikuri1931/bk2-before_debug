Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about'
  get "users/:id" => "users#show", as: :mypage
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
  end
  get 'users/:id/follows' => "users#follows", as: :follows
  get 'users/:id/followers' => "users#followers", as: :followers
  get 'search' => "search#search"
  resources :books do
  	resource :favorites,only: [:create,:destroy]
  	resources :book_comments, only: [:create, :destroy]
  end
end