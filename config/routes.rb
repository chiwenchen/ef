Rails.application.routes.draw do
  devise_for :users
  
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :home do
    collection do
      get 'landing', to: 'home#landing'
      get 'set_locale', to: 'home#set_locale'
    end
  end

  resources :users, only: [:new, :create]

  resources :service_requests do
    resources :comments, only: [:create]
  end
  # resources :staffs
  namespace :customer do
    root to: 'service_requests#index'
    resources :service_requests, only: [:index, :show, :new, :create, :edit, :update] do
      member do
        post 'change_state', to: 'service_requests#change_state'
      end
    end
  end

  namespace :staff do
    root to: 'service_requests#index'
    resources :service_requests, only: [:show, :index] do
      member do
        post 'change_state', to: 'service_requests#change_state'
      end
    end
  end

  namespace :admin do
    root to: 'service_requests#index'
    resources :service_requests, only: [:show, :index] do
      member do
        post 'change_state', to: 'service_requests#change_state'
        post 'update_assignment', to: 'service_requests#update_assignment'
      end
    end
    resources :staffs, only: [:index, :show]
    resources :customers, only: [:index, :show]
  end

end