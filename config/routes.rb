Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :home do
    collection do
      get 'landing', to: 'home#landing'
    end
  end

  resources :service_requests
  resources :admin
  resources :staffs
  namespace :customer do
    root to: 'service_requests#index'
    resources :service_requests
  end
  
end