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

  # Rutas públicas para mascotas
  resources :pets, only: [:index, :show] do
    resources :adoptions, only: [:new, :create, :index]
  end

  # Rutas para adopciones
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

  # Rutas para donaciones
  resources :donations, only: [:new, :create, :index] do
    collection do
      get :success
      get :cancel
    end
  end

  # Área de usuario
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
  end


  # Helper para imágenes
  direct :pet_image do |pet, options|
    if pet.image.attached?
      route_for(:rails_blob, pet.image, options)
    else
      asset_path('default_pet.png')
    end
  end
end