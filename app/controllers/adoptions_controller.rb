class AdoptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pet

  def new
    @adoption = @pet.adoptions.new(
      email: current_user.email,
      full_name: "#{current_user.first_name} #{current_user.last_name}",
      phone: current_user.phone
    )
  end

  def create
    @adoption = @pet.adoptions.new(adoption_params)
    @adoption.user = current_user

    if @adoption.save
      redirect_to @pet, notice: 'Solicitud enviada correctamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def adoption_params
    params.require(:adoption).permit(:full_name, :phone, :email, :reason)
  end
end