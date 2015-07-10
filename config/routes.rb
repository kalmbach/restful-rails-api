Rails.application.routes.draw do
  namespace :api do
    resources :users, :repositories
  end
end
