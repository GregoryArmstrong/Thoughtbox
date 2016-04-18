Rails.application.routes.draw do
  get '/', to: 'welcome#index', as: 'root'

  resources :users, only: [:new, :create]
  resources :links, only: [:index]
  resources :sessions, only: [:destroy]

end
