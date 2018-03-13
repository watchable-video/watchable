require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :accounts do
    collection do
      get :save
    end
  end

  namespace :tv do
    get :app
    resource :search
    resource :authenticate
    resource :media_location
    resources :videos do
      scope module: 'videos' do
        resource :watch
      end
      member do
        delete :mark_watched
      end
    end
  end
end
