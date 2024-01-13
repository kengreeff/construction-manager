Rails.application.routes.draw do
  resources :posts
  # Authentication
  get  "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  get  "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  resources :sessions, only: [:index, :show, :destroy]
  resource  :password, only: [:edit, :update]
  namespace :identity do
    resource :email,              only: [:edit, :update]
    resource :email_verification, only: [:show, :create]
    resource :password_reset,     only: [:new, :edit, :create, :update]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "projects#index"

  # Clients
  resources :clients

  # Comments
  resources :comments, only: [:create, :destroy]

  # Documents
  resources :documents

  # Invoices
  resources :invoices

  # Projects
  resources :projects do
    # Invoice
    resources :invoices

    # Spaces
    get "spaces/bulk_new", to: "project_spaces#bulk_new"
    post "spaces/bulk_create", to: "project_spaces#bulk_create"
    resources :spaces, controller: "project_spaces" do
      post :duplicate
      resources :items, controller: "project_items"
    end

    # Quotes
    resources :quotes
  end

  # Project Items
  resources :project_items, only: [:create, :destroy, :update] do
    post :duplicate
  end

  # Quotes
  resources :quotes

  # Users
  resources :users
end
