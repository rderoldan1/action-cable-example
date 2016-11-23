Rails.application.routes.draw do
  get 'dashboard/index'

  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'

  root 'products#index'
end
