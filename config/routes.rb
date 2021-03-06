# frozen_string_literal: true

Rails.application.routes.draw do
  mount Shrine.presign_endpoint(:cache) => '/s3/params'

  resource :account, only: %i[show update], controller: :account
  resources :profiles, only: %i[show index], param: :username do
    resources :posts, only: :index
  end

  resources :posts do
    resource :like, only: %i[create destroy]
    resources :comments, only: %i[index create]
  end
end
