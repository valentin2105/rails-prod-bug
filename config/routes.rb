Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  # Create Index (form) & Post (creation)
  get '/create', :to => 'create#index'
  post '/create', :to => 'create#post'
  # Show VM routes 
  get '/show/:id' => 'show#index'
  get '/show/stop/:id' => 'show#stop'
  delete '/show/:id' => 'show#destroy'
  # Edit VM routes
  get '/edit/:id', :to => 'edit#index'
  post '/edit/:id', :to => 'edit#post'
  # N.O.C routes
  get '/ops', :to => 'ops#index'
  # Notes resources CRUD
  resources :notes
  # Rails-admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

end
