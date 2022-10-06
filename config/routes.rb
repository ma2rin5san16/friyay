Rails.application.routes.draw do
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/logout', to: "sessions#destroy"
  root to: "static_pages#top"
  resources :users
  resources :users, only: [:show] do 
    get :favorites, on: :collection 
  end
  resources :users
  resources :tasks do
    resource :favorites, only: [:create, :destroy]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
