module Admin
  class DonationsController < ApplicationController
    before_action :authenticate_admin!
    
    def index
      @donations = Donation.all.order(created_at: :desc)
    end

    private
    
    def authenticate_admin!
      unless current_user.admin?
        redirect_to root_path, alert: "No tienes permisos para acceder a esta sección"
      end
    end
  end
end