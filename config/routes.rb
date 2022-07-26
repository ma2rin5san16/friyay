Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root "static_pages#top"
  get '/privacy_policy', to: "static_pages#privacy_policy"
  get '/kiyaku', to: "static_pages#kiyaku"
  get 'guest_sessions/new'
  post '/guest_login', to: "guest_sessions#create"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  get "/suggested_list", to: "users#suggested_list"
  get "/favorited_list", to: "users#favorited_list"
  resources :users, only: %i[new create]
  resources :tasks, only: %i[index new create edit update destroy] do
    get "random_show"
    resources :favorites, only: %i[create destroy edit update] do
      patch "toggle_status"
    end
  end
  resources :rankings, only: %i[index]
  resource :profile, only: %i[show edit update]
  resources :password_resets, only: %i[new create edit update]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
