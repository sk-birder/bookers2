Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users
  resources :users, only: [:new, :create, :index, :show, :update, :edit]
  resources :books
  get 'homes/about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# 一時保管
# get 'users/new'
# get 'users/index'
# get 'users/show'
# get 'users/edit'
# get 'books/index'
# get 'books/show'
# get 'books/edit'
# get 'homes/top'