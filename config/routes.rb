Rails.application.routes.draw do
  root "articles#index"

  resources :articles do
    resources :comments
  end

  resources :users, only: [:show, :create]

  get 'sign-up', to: 'users#new'

end
