Rails.application.routes.draw do
  devise_for :users
  root 'tone_check_groups#index'

  resources :tone_check_groups
  resources :transcriptions, only: [:create]

  post '/tone_check_groups/:id/recheck', to: 'tone_check_groups#recheck', as: :tone_check_group_recheck
  get '/tone_check_groups/:id/:token', to: 'tone_check_groups#show', as: :tone_check_group_shared

  post '/twilml/pause', to: 'twilml#pause', as: :twilml_pause

  post '/tone_checks/:id/status', to: 'tone_checks#status', as: :tone_check_status
  post '/tone_checks/:id/recheck', to: 'tone_checks#recheck', as: :tone_check_recheck
  get '/tone_checks/:id', to: 'tone_checks#show', as: :tone_check
  put '/tone_checks/:id', to: 'tone_checks#update', as: :tone_check_update
end
