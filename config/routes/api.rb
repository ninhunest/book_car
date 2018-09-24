require "api_constraints"

namespace :api, defaults: {format: "json"} do
  # resources :sessions, only: :create
  scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    resources :roles
  end
end
