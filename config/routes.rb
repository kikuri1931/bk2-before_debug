Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about'
  get "users/:id" => "users#show", as: :mypage
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
end