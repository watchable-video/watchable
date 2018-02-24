Rails.application.routes.draw do
  resources :oauth_two_authorizations do
    collection do
      get :save
    end
  end

  namespace :tv do
    resources :apps
  end
end
