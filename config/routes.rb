require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  get "/activate/:token", to: "accounts#create", as: :activate

  resources :accounts do
    collection do
      get :save
    end
  end

  namespace :tv do
    get :app
    resource :search
    resources :activation_tokens
    resource :authenticate do
      member do
        get :sync_status
      end
    end
    resources :playlists, id: /[^\.]+/
    resources :playlist_videos, only: [:index]
    resources :channels, id: /[^\.]+/
    resources :videos do
      scope module: "videos" do
        resource :watch
        resource :media_location
      end
    end
  end
end
