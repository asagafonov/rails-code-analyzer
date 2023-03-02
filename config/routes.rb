# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :web do
    get 'repository_checks/create'
    get 'repository_checks/update'
  end
  scope module: :web do
    resources :repositories do
      resources :repository_checks
    end

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    get 'auth/logout', to: 'auth#end_session'

    root 'users#index'
  end
end
