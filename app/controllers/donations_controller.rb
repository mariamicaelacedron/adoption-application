class DonationsController < ApplicationController
  def index
    @donations = Donation.all.order(created_at: :desc)
  end

  def new
    @donation = Donation.new
  end

  def create
    amount = params[:donation][:amount].to_f
    if amount > 0
      redirect_to mercado_pago_create_payment_path(amount: amount)
    else
      redirect_to new_donation_path, alert: 'El monto debe ser mayor a cero'
    end
  end
end