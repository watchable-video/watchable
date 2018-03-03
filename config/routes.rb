Rails.application.routes.draw do

  resources :accounts do
    collection do
      get :save
    end
  end

  namespace :tv do
    resources :apps
    resources :videos do
      member do
        delete :mark_watched
      end
    end
  end
end
