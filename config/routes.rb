Rails.application.routes.draw do

  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

 scope module: :public do
  root to: 'homes#top'
  get '/about' => 'homes#about', as: 'about'
  resources :items, only: [:index, :show]
  resources :customers, only: [:edit, :update]
   get 'customers/my_page' => 'customers#show', as: 'show'
   get 'customers/quit' => 'customers#quit', as: 'quit'
   patch 'customers/out' => 'customers#out', as: 'out'

  resources :cart_items, only: [:index, :update, :destroy, :create]
   delete 'cart_items/all_destroy' => 'cart_items#all_destroy', as: 'all_destroy'


  resources :orders, only: [:new, :create, :index, :show]

  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
 end

 namespace :admin do
  get '/admin' => 'homes#top', as: 'top'
  resources :items, only: [:index, :new, :create, :show, :edit, :update]
  resources :genres, only: [:index, :create, :edit, :update]
  resources :customers, only: [:index, :show, :edit, :update]
  resources :orders, only: [:show, :update]
  resources :order_items, only: [:update]
 end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
