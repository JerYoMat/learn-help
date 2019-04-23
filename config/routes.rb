Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
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
end
