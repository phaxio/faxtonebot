Rails.application.routes.draw do
  root 'tone_check_groups#index'

  resources :tone_check_groups
end
