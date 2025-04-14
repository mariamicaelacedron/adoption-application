class AdoptionApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pet, only: [:new, :create]

  def new
    @application = @pet.adoption_applications.new
  end

  def create
    @application = @pet.adoption_applications.new(application_params)
    @application.user = current_user

    if @application.save
      redirect_to @pet, notice: 'Solicitud de adopción enviada correctamente.'
    else
      render :new
    end
  end

  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def application_params
    params.require(:adoption_application).permit(:application_text)
  end
end