AppTest::Application.routes.draw do
  root to: 'static#home'
  get '/sign_up', to: 'users#new'
  get '/login', to: 'sessions#new'
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:create]
end
