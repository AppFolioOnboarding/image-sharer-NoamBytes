Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :images, only: %i[new create show index]
  get 'images/search/:id', to: 'images#search', as: 'search'

  root 'images#index'
end
