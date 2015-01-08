Rails.application.routes.draw do
  root to: "polls#active"
  
  devise_for :users
  
  get 'polls/active', as: :active_polls
  get 'polls/completed', as: :completed_polls
    
  resources :polls, only: [:new, :create, :show]
  resources :votes, only: :create
end
