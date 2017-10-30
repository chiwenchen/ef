Rails.application.routes.draw do

  resources :webhooks, only: [] do
    collection do
      post 'line', to: 'webhooks#line'
    end
  end
  devise_for :users, skip: :registrations
  
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :home do
    collection do
      get 'landing', to: 'home#landing'
      post 'set_locale', to: 'home#set_locale'
    end
  end

  resources :users, only: [:update, :edit] do
    member do
      post 'reset_password', to: 'users#reset_password'
    end
  end

  resources :service_requests do
    resources :comments, only: [:create]
  end
  # resources :staffs
  namespace :customer do
    root to: 'service_requests#index'
    resources :service_requests do
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
      collection do
        get 'owned', to: 'service_requests#owned_index'
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
    get 'admin_index', to: 'staffs#admin_index'
    get 'sales_index', to: 'staffs#sales_index'
    get 'techs_index', to: 'staffs#techs_index'
    resources :categories, except: [:show, :edit, :update]
    resources :staffs, only: [:show]
    resources :customers, only: [:index, :show] do
      collection do
         get 'responsible_table', to: 'customers#responsible_table' 
      end
    end
    resources :users, only: [:new, :create, :edit, :update]
  end

end