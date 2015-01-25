FMF::Application.routes.draw do
  get "identities/new"
  get "static_pages/home"
  get "static_pages/help"
  get "static_pages/about"
  get "static_pages/contact"
  
  resources :identities, :users do
    member do
      get :following, :followers
    end
  end
  
  resources :sessions,      only: [:new, :create, :destroy]
  resources :microposts,    only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  
  #root to: "sessions#new" 
  root  'static_pages#home'
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
 # match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signup',  to: 'identities#new',       via: 'get'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'  
end