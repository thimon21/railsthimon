Rails.application.routes.draw do
  resources :users
  resources :products
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'static_pages#home'
  post 'guest_sign_in', to: 'sessions#guest_sign_in'
  resources :carts, only: [:show]
  post '/add_item', to: 'carts#add_item'
  post '/update_item', to: 'carts#update_item'
  delete '/delete_item', to: 'carts#delete_item'
  get 'orders/purchase_completed', to: "orders#purchase_completed"
  resources :orders, only: [:new, :create, :show, :index, :destroy]
end
