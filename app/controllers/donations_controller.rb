class DonationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @donations = current_user.donations.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @donation = Donation.new
  end

  def create
    @donation = current_user.donations.new(donation_params)
    if @donation.save
      redirect_to donations_path, notice: '¡Gracias por tu donación!'
    else
      render :new
    end
  end

  private

  def donation_params
    params.require(:donation).permit(:amount, :donation_type, :description, :payment_method, :payment_proof)
  end
end