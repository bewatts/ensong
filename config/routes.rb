TTR::Application.routes.draw do
  get "loop_collections/show"

  root :to => 'static_pages#root'
  resources :users, :only => [:new, :create, :show]
  resource :session, :only => [:new, :create, :destroy]

  get 'explore', to: 'loop_collections#index'
  get 'listen/:id', to: 'loop_collections#show', :as => :listen
  post 'users/demo', to: 'users#demo', :as => :create_demo
  
  
  resources :loop_collections, :only => [:new, :create, :show, :destroy, :index]
  
  namespace :api do 
    resources :loop_collections, 
              :only => [:show], 
              :default => {format: 'json'}

    resources :favorites, 
              :only => [:create, :index], 
              :default => {format: 'json'}
              
    delete "favorites/destroy"          

  end
end
