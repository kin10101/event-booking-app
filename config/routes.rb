Rails.application.routes.draw do
  # Root -> login/signup
  root "sessions#new"

  # Authentication
  resources :users, only: [:new, :create]
  resource  :session, only: [:new, :create, :destroy]
  resources :passwords, param: :token

  # Events & Registrations
  resources :events do
    resources :registrations, only: [:create, :edit, :update, :destroy]
  end

  # Admin namespace
  namespace :admin do
    get "dashboard", to: "dashboards#index"  
    resources :events do
      member do
        patch :close
        patch :reopen
      end
      collection do
        delete :bulk_delete
      end
    end
    resources :registrations do
      collection do
        delete :bulk_delete
      end
    end
  end

  # Healthcheck
  get "up" => "rails/health#show", as: :rails_health_check
end
