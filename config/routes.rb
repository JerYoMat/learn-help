Rails.application.routes.draw do
  root 'static_pages#home'
  resources :units, only: [:index, :show]
  resources :users
  get '/contact', to: 'static_pages#contact'
  get '/credits', to: 'static_pages#credits'
  get '/code_of_conduct', to: 'static_pages#code_of_conduct'
  get '/about', to: 'static_pages#about'
  get '/help', to: 'static_pages#help'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/auth/facebook/callback' => 'sessions#oauth_create'
  get '/auth/github/callback' => 'sessions#oauth_create'
  get '/.well-known/acme-challenge/2gqtURELxXuPONd1-cLbmsgckPDdnkmbg6K02lam0m8' => 'static_pages#acme_challenge1'
end
