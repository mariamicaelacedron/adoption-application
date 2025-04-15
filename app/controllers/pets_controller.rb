class PetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_pet, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    @pets_by_type = {
      dog: Pet.dog.available.with_attached_image,
      cat: Pet.cat.available.with_attached_image,
      guinea_pig: Pet.guinea_pig.available.with_attached_image,
      other: Pet.other.available.with_attached_image
    }
  end

  def show
      respond_to do |format|
        format.html
        format.json { render json: @pet }
      end
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    
    if @pet.save
      if params[:pet][:image].present?
        @pet.image.attach(params[:pet][:image])
      end
      
      redirect_to @pet, notice: 'Mascota añadida correctamente.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if params[:pet][:remove_image] == "1"
      @pet.image.purge
    end
    
    if @pet.update(pet_params)
      if params[:pet][:image].present?
        @pet.image.attach(params[:pet][:image])
      end
      
      redirect_to @pet, notice: 'Mascota actualizada correctamente.'
    else
      render :edit
    end
  end

  def destroy
    @pet.destroy
    redirect_to pets_url, notice: 'Mascota eliminada correctamente.'
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :breed, :age, :pet_type, :description, :gender, :size, :status)
  end
end