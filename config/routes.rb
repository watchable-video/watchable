Rails.application.routes.draw do
  namespace :tv do
    resources :apps
  end
end
