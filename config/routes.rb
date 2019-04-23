Rails.application.routes.draw do
  root 'static_pages#home'
  resource :units, only: [:index, :show]
  resource :users
  get '/contact', to: 'static_pages#contact'
  get '/credits', to: 'static_pages#credits'
  get '/code_of_conduct', to: 'static_pages#code_of_conduct'
  get '/about', to: 'static_pages#about'
  get '/help', to: 'static_pages#help'
  get '/signup', to: 'users#new'
end
