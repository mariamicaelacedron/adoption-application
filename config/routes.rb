Rails.application.routes.draw do
  root 'pets#index'
  
  # Configuración mejorada de Devise
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    sign_up: 'register'
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Rutas personalizadas para autenticación
  get 'login', to: redirect('/login') # Redundante pero útil para legacy
  get 'register', to: redirect('/register') # Redundante pero útil para legacy
  delete 'logout', to: 'users/sessions#destroy', as: :logout

  # Rutas principales para mascotas
  resources :pets, only: [:index, :show] do
    resources :adoption_applications, only: [:new, :create, :index]
    # Agregamos :index para ver solicitudes de una mascota específica
  end

  # Rutas para manejo de solicitudes de adopción
  resources :adoption_applications, only: [:show, :destroy] do
    member do
      patch :approve
      patch :reject
      get :manage # Nueva ruta para panel de administración
    end
    collection do
      get :pending # Para ver todas las solicitudes pendientes
    end
  end

  # Rutas para donaciones
  resources :donations, only: [:new, :create, :index] do
    collection do
      get :success # Página después de donación exitosa
      get :cancel # Página si se cancela la donación
    end
  end

  # Área de usuario
  get 'my_applications', to: 'adoption_applications#user_applications', as: :my_applications
  get 'my_profile', to: 'users#show', as: :my_profile

  # Área de administración
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :pets, except: [:index, :show] do
      collection do
        get :import # Para importar mascotas desde CSV
      end
    end
    resources :adoption_applications, only: [:index] # Panel de control de solicitudes
  end

  # Helper para imágenes
  direct :pet_image do |pet, options|
    if pet.image.attached?
      route_for(:rails_blob, pet.image, options)
    else
      "/default_pet.png"
    end
  end
end