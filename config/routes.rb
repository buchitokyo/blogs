Rails.application.routes.draw do

  resources :blogs do
  collection do
      post :confirm
  end
  end

  root to: 'tops#index'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users
end
