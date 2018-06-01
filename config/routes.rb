Rails.application.routes.draw do
  devise_for :users
  resources :posts
  root 'home#index'
  
  get 'mypage' => 'posts#mypage'
  post 'search' => 'posts#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
