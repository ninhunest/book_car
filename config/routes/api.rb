require "api_constraints"

namespace :api, defaults: {format: "json"} do
  # resources :sessions, only: :create
  scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    devise_scope :user do
      post "sign_up", :to => "registrations#create"
      post "sign_in", :to => "sessions#create"
      delete "sign_out", :to => "sessions#destroy"
    end
    resources :roles
    resources :users
  end
end
