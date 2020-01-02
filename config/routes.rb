# frozen_string_literal: true

if Rails.env.development?
  require "sidekiq/web"
end

Rails.application.routes.draw do
  devise_for :users

  if Rails.env.development?
    namespace :backoffice do
      mount Sidekiq::Web, at: "sidekiq"
    end
  end

  namespace :universe do
    resources :alliances, only: [:index, :show]

    resources :corporations, only: [:index, :show]

    resources :characters, only: [:index, :show]

    resources :categories, only: [:index, :show]

    resources :groups, only: :show

    resources :market_groups, only: [:index, :show]

    resources :types, only: :show
  end

  resources :characters, only: [:index, :show, :update, :destroy] do
    resources :assets, only: :index

    resources :loyalty_points, only: :index

    resources :employment_histories, only: :index

    resources :skills, only: :index

    resources :mails, only: :index
  end

  resource :profile, only: :show

  resource :faq, only: :show

  namespace :auth do
    namespace :eve_online_sso do
      resource :callback, only: :show
    end
  end

  namespace :api, defaults: {format: "json"} do
    resources :docs, only: :index

    resource :sign_up, only: :create

    resource :sign_in, only: :create

    resource :sign_out, only: :destroy

    resource :change_password, only: :create

    resource :request_password_reset, only: :create

    resource :reset_password, only: :create

    resources :sessions, only: [:index, :destroy]

    resource :profile, only: :show

    resources :characters, only: [:index, :show, :destroy]

    namespace :eve do
      resources :alliances, only: [:index, :show] do
        resources :characters, only: :index, controller: :alliance_characters

        resources :corporations, only: :index, controller: :alliance_corporations
      end

      resources :corporations, only: [:index, :show] do
        resources :characters, only: :index, controller: :corporation_characters
      end

      resources :characters, only: [:index, :show] do
        resources :corporations_history, only: :index, controller: :character_corporations_history
      end

      resources :types, only: [:index, :show]

      resource :server_status_last, only: :show
    end
  end

  root to: "welcome#index"
end
