Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users

  get 'api/observations', to: 'observations#index'

  root to: 'root#index'
end
