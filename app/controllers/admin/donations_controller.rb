module Admin
  class DonationsController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin
    before_action :set_donation, only: [:show, :destroy, :approve, :cancel]

    def index
      @donations = Donation.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
      @pending_count = Donation.pending.count
    end

    def show
    end

    def destroy
      @donation.destroy
      redirect_to admin_donations_path, notice: 'Donación eliminada correctamente.'
    end

    def approve
      if @donation.pending?
        @donation.update!(status: :completed)
        redirect_to admin_donations_path, notice: 'Donación aprobada correctamente.'
      else
        redirect_to admin_donations_path, alert: 'Solo se pueden aprobar donaciones pendientes'
      end
    end

    def cancel
      if @donation.pending?
        @donation.update!(status: :canceled)
        redirect_to admin_donations_path, notice: 'Donación cancelada correctamente.'
      else
        redirect_to admin_donations_path, alert: 'Solo se pueden cancelar donaciones pendientes'
      end
    end

    private

    def set_donation
      @donation = Donation.find(params[:id])
    end

    def require_admin
      unless current_user.admin?
        redirect_to root_path, alert: 'No tienes permisos para acceder a esta sección'
      end
    end
  end
end