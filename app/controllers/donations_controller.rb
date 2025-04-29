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
    
    if @donation.payment_method == 'mercado_pago'
      begin
        # Configurar Mercado Pago
        require 'mercadopago'
        sdk = MercadoPago::SDK.new(ENV['MERCADOPAGO_ACCESS_TOKEN'])
        
        # Crear preferencia de pago
        preference_data = {
          items: [{
            title: "Donación",
            unit_price: @donation.amount.to_f,
            quantity: 1
          }],
          back_urls: {
            success: donations_success_url,
            failure: donations_failure_url,
            pending: donations_pending_url
          },
          auto_return: "approved"
        }
        
        preference_response = sdk.preference.create(preference_data)
        preference = preference_response[:response]
        
        if preference["id"].present?
          @donation.mercado_pago_preference_id = preference["id"]
          @donation.status = 'pending'
          
          if @donation.save
            redirect_to preference["init_point"], allow_other_host: true
          else
            render :new
          end
        else
          flash.now[:error] = "Error al crear la preferencia de pago"
          render :new
        end
      rescue => e
        flash.now[:error] = "Error al procesar el pago: #{e.message}"
        render :new
      end
    elsif @donation.payment_method == 'cbu'
      @donation.status = 'pending'
      if @donation.save
        redirect_to donations_path, notice: '¡Gracias por tu donación! Por favor, realiza la transferencia al CBU proporcionado y sube el comprobante.'
      else
        render :new
      end
    else
      if @donation.save
        redirect_to donations_path, notice: '¡Gracias por tu donación! El administrador la revisará pronto.'
      else
        render :new
      end
    end
  end

  def success
    @donation = current_user.donations.find_by(mercado_pago_preference_id: params[:preference_id])
    if @donation
      @donation.update(status: 'completed')
      redirect_to donations_path, notice: '¡Gracias por tu donación!'
    else
      redirect_to donations_path, alert: 'No se pudo encontrar la donación.'
    end
  end

  def failure
    redirect_to donations_path, alert: 'Hubo un error al procesar el pago. Por favor, intenta nuevamente.'
  end

  def pending
    redirect_to donations_path, notice: 'Tu donación está pendiente de confirmación.'
  end

  private

  def donation_params
    params.require(:donation).permit(:amount, :donation_type, :description, :payment_method, :payment_proof)
  end
end