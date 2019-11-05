Rails.application.routes.draw do
  devise_for :entities
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :transactions, only: :create
end
