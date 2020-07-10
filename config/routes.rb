Rails.application.routes.draw do
  resources :users, except: %i[index]
  resources :opinions, except: %i[show]
  resources :followings, only: %i[destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'opinions#index'
  resources :sessions, only: %i[new create destroy]
  get 'signup', to: 'users#new', as: 'signup'
  post 'signup', to: 'users#create', as: 'signup2'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'following/:id', to: 'followings#create', as: 'follow'
  get 'retweet/:id', to: 'opinions#retweet', as: 'retweet'
end
