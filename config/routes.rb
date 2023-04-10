require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'messages#new'
  resources :messages, only: %i[new create show]
  mount Sidekiq::Web => '/sidekiq'
end
