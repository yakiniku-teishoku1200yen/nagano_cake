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
  resources :customers, only: [:edit, :update] do
   collection do
    get 'my_page' => 'customers#show'
    get 'quit'
    patch 'out'
   end
  end

  resources :cart_items, only: [:index, :update, :destroy, :create] do
   collection do
    delete 'all_destroy'
   end
  end

   get 'orders/confirm' => 'orders#confirm', as: 'confirm'
   get 'orders/thanks' => 'orders#thanks', as: 'thanks'
  resources :orders, only: [:new, :create, :index, :show]
  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
 end

 namespace :admin do
  get '/admin' => 'homes#top', as: 'top'
  resources :items, only: [:index, :new, :create, :show, :edit, :update]
  resources :genres, only: [:index, :create, :edit, :update]
  resources :customers, only: [:index, :show, :edit, :update]
  resources :orders, only: [:index, :show, :update]
  resources :order_items, only: [:update]
 end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
