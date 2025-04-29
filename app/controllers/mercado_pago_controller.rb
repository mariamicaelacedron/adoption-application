class MercadoPagoController < ApplicationController
  before_action :authenticate_user!

  def create_preference
    require 'mercadopago'
    
    begin
      sdk = MercadoPago::SDK.new(ENV['MERCADOPAGO_ACCESS_TOKEN'])
      
      preference_data = {
        items: [{
          title: "Donación a Salvando Patitas",
          unit_price: params[:amount].to_f,
          quantity: 1
        }],
        back_urls: {
          success: donations_success_url,
          failure: donations_failure_url,
          pending: donations_pending_url
        },
        auto_return: "approved",
        external_reference: current_user.id.to_s
      }
      
      preference_response = sdk.preference.create(preference_data)
      preference = preference_response[:response]
      
      if preference["id"].present?
        # Guardar la preferencia en la sesión para usarla después
        session[:mercado_pago_preference_id] = preference["id"]
        session[:donation_amount] = params[:amount]
        
        redirect_to preference["init_point"], allow_other_host: true
      else
        redirect_to donations_path, alert: "Error al crear la preferencia de pago"
      end
    rescue => e
      redirect_to donations_path, alert: "Error al procesar el pago: #{e.message}"
    end
  end

  def success
    @donation = current_user.donations.find_by(mercado_pago_preference_id: session[:mercado_pago_preference_id])
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
end 