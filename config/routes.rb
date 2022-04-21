# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#index'
  resources :posts do
    scope module: 'posts' do
      resources :comments, only: [:create]
      resources :likes, only: %i[create destroy]
    end
  end

  scope module: 'posts' do
    resources :comments, only: :destroy
  end
end
