Rails.application.routes.draw do
  resources :schedules
  root 'schedules#index'
end
