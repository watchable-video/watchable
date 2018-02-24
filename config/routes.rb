Rails.application.routes.draw do

  resources :accounts do
    collection do
      get :save
    end
  end

  namespace :tv do
    resources :apps
  end
end
