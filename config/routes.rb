Rails.application.routes.draw do

  resources :accounts do
    collection do
      get :save
    end
  end

  namespace :tv do
    get :app
    resource :search
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
