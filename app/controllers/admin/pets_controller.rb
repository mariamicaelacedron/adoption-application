module Admin
  class PetsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin
    before_action :set_pet, only: [:show, :edit, :update, :destroy]  # Quité :index del set_pet

    def index
      @pets = Pet.all.with_attached_image.order(created_at: :desc)
    end

    def show
    end

    def new
      @pet = Pet.new
    end

    def create
      @pet = Pet.new(pet_params)
      if @pet.save
        redirect_to admin_pet_path(@pet), notice: 'Mascota creada exitosamente'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @pet.update(pet_params)
        redirect_to admin_pet_path(@pet), notice: 'Mascota actualizada correctamente.'
      else
        render :edit
      end
    end

    def destroy
      @pet.destroy
      redirect_to admin_pets_url, notice: 'Mascota eliminada correctamente.'
    end

    private

    def set_pet
      @pet = Pet.find(params[:id])
    end

    def pet_params
      params.require(:pet).permit(:name, :breed, :age, :description, :image, :pet_type, :status)
    end

    def authorize_admin
      redirect_to root_path, alert: "No autorizado" unless current_user.admin?
    end
  end
end