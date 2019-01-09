Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/home", to: "static_pages#home"
    get "/about", to: "static_pages#about"
    get "/help", to: "static_pages#help"
    get "/signup", to: "users#new"
    get "/users", to: "users#index"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    resources :microposts, only: %i(create destroy)
    resources :relationships, only: %i(create destroy)
    resources :following, only: %i(show)
    resources :followers, only: %i(show)
  end
  resources :account_activations, only: %i(edit)
  resources :password_resets, only: %i(new create edit update)
end
