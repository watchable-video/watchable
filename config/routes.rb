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
    resource :media_location
    resources :activation_tokens
    resource :authenticate do
      member do
        get :sync_status
      end
    end
    resources :videos do
      scope module: "videos" do
        resource :watch
      end
      member do
        delete :mark_watched
      end
    end
  end
end
