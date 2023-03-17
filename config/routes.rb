# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :checks, only: :create
  end

  scope module: :web do
    resources :repositories, only: %i[index show new create] do
      scope module: :repositories do
        resources :checks, only: %i[show create]
      end
    end

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    get 'auth/logout', to: 'auth#end_session'

    root 'users#index'
  end
end
