Rails.application.routes.draw do
  root to: "homes#top"
  get 'home/about' => 'homes#about', as: 'about'
  devise_for :users
  resources :users, only: [:index, :show, :update, :edit]
  resources :books
end
