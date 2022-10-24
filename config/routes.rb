Rails.application.routes.draw do
  get 'guest_sessions/new'
  post '/guest_login', to: "guest_sessions#create"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  root to: "ranking#ranking_index_for_desktop"
  resources :users
  resources :tasks do
    get "random_show"
    resources :favorites, only: [:create, :destroy, :edit, :update] do
      patch "toggle_status"
    end
  end
  resources :random_tasks, only:[:show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
