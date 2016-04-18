Rails.application.routes.draw do
  get '/', to: 'welcome#index', as: 'root'
  post '/login', to: 'sessions#create'

  resources :users, only: [:new, :create]
  resources :links, only: [:index, :new, :create, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]

end
