module Admin
  class AdoptionsController < ApplicationController
    before_action :authenticate_user!
    before_action :verify_admin
    before_action :set_adoption, only: [:show, :approve, :reject]

    def index
      @status = params[:status] || 'pending'
      @adoptions = Adoption.includes(:pet, :user).where(status: @status).order(created_at: :desc)
    end

    def show
      @pet = @adoption.pet
    end

    def approve
      if @adoption.approved!
        redirect_to admin_adoptions_path, 
        notice: 'Solicitud aprobada exitosamente.'
      else
        redirect_to admin_adoption_path(@adoption), 
        alert: 'Error al aprobar la solicitud.'
      end
    end

    def reject
      if @adoption.rejected!
        redirect_to admin_adoptions_path, 
        notice: 'Solicitud rechazada exitosamente.'
      else
        redirect_to admin_adoption_path(@adoption), 
        alert: 'Error al rechazar la solicitud.'
      end
    end

    private

    def set_adoption
      @adoption = Adoption.find(params[:id])
    end

    def verify_admin
      redirect_to root_path, alert: 'No autorizado' unless current_user.admin?
    end
  end
end