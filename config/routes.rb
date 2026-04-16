Rails.application.routes.draw do
  root "owners#index"

  resources :owners, only: [:index, :show]
  resources :pets, only: [:index, :show]
  resources :vets, only: [:index, :show]
  resources :appointments, only: [:index, :show]
  
end
