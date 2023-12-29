Rails.application.routes.draw do
  root "articles#index"

  resources :articles do
    member do
      get :publish
    end
    resources :comments
  end

  resources :users, only: [:show, :create]

  get 'sign-up', to: 'users#new'
  get 'log-in', to: 'sessions#new'
  post 'log-in', to: 'sessions#create'
  delete 'log-out', to: 'sessions#destroy'


end
