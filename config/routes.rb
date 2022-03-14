Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :events, except: [:create] do
    resources :bookings, only: [:create]
    post "/favourite", to: "events#favourite"
    delete "/unfavourite", to: "events#unfavourite"
  end

  resources :bookings, only: [:show, :edit, :update] do
    resources :reviews, only: [:new, :create]
  end

  resources :chatrooms, only: [:index, :show ] do
    resources :messages, only: :create
  end

  resources :studios, only: [:new, :show, :create, :edit, :update] do
    resources :events, only: [:create]
    resources :chatrooms, only: [:create]
  end

  get '/dashboard', to: 'pages#dashboard'
end
