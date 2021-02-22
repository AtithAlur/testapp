# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    resources :magic, param: :uid, controller: :magic, only: %i[create show destroy]
    patch 'magic', to: 'magic#update'
    resources :products, only: %i[index]
  end
end
