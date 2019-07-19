Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'

  #投稿
  resources :posts
  #ユーザー
  resources :users, only: [:show]
end
