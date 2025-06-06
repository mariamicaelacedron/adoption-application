Rails.application.routes.draw do
  root 'pets#index'
  
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register'
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :pets, only: [:index, :show] do
    resources :adoptions, only: [:new, :create, :index]
  end

  resources :adoptions, only: [:show, :destroy] do
    member do
      patch :approve
      patch :reject
      get :manage
    end
    collection do
      get :pending
    end
  end
  resources :donations, only: [:index, :new, :create]
  
  namespace :mercado_pago do
    post 'create_payment', to: 'mercado_pago#create_payment'
    get 'success', to: 'mercado_pago#success', as: 'success'
    get 'failure', to: 'mercado_pago#failure', as: 'failure'
    get 'pending', to: 'mercado_pago#pending', as: 'pending'
  end

  get 'my_applications', to: 'adoption_applications#user_applications'
  get 'my_profile', to: 'users#show'

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :pets do 
      collection do
        get :import
      end
    end
    resources :adoption_applications, only: [:index]
    resources :adoptions, only: [:index, :show] do
      member do
        post :approve
        post :reject
      end
    end
    resources :donations, only: [:index, :show, :destroy] do
      member do
        patch :approve 
        patch :cancel 
      end
    end
  end

  direct :pet_image do |pet, options|
    if pet.image.attached?
      route_for(:rails_blob, pet.image, options)
    else
      asset_path('default_pet.png')
    end
  end
end