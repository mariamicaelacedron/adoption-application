class PetsController < ApplicationController
  before_action :redirect_admin_to_admin_panel, only: [:index]

  def index
    @pets = Pet.all.includes(:image_attachment).order(created_at: :desc).page(params[:page]).per(9)
  end

  def show
    @pet = Pet.find(params[:id])
  end

  private

  def redirect_admin_to_admin_panel
    if current_user&.admin?
      redirect_to admin_pets_path
    end
  end
end