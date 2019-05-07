Rails.application.routes.draw do
  root 'static_pages#home'
  resources :topics, only: [:index, :show]
  resources :tips, only: [:create, :destroy] 
  resources :tip_ratings, only: [:create]
  resources :users do
    member do
      get :following, :followers
    end
  end
  get '/acknowledgements', to: 'static_pages#credits'
  get '/code_of_conduct', to: 'static_pages#code_of_conduct'
  get '/about', to: 'static_pages#about'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/auth/facebook/callback' => 'sessions#oauth_create'
  get '/auth/github/callback' => 'sessions#oauth_create'
  resources :relationships, only: [:create, :destroy]
  get '/.well-known/acme-challenge/2gqtURELxXuPONd1-cLbmsgckPDdnkmbg6K02lam0m8' => 'static_pages#acme_challenge1'
end
