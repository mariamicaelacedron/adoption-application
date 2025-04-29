class DonationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @donations = current_user.donations.order(created_at: :desc).page(params[:page]).per(10)
    
    # Crear preferencia de Mercado Pago
    require 'mercadopago'
    sdk = Mercadopago::SDK.new(ENV['MERCADOPAGO_ACCESS_TOKEN'])
    
    preference_data = {
      items: [{
        title: 'Donación a Salvando Patitas',
        unit_price: 100.0,
        quantity: 1
      }],
      back_urls: {
        success: root_url + 'donations/success',
        failure: root_url + 'donations/failure',
        pending: root_url + 'donations/pending'
      },
      payment_methods: {
        installments: 1
      },
      test_mode: true
    }
    
    begin
      preference_response = sdk.preference.create(preference_data)
      Rails.logger.info "Mercado Pago Response: #{preference_response.inspect}"
      
      if preference_response[:response] && preference_response[:response]['id']
        @preference_id = preference_response[:response]['id']
      else
        error_message = preference_response[:response] ? preference_response[:response].to_s : "No se recibió respuesta"
        flash.now[:error] = "Error al crear la preferencia de pago: #{error_message}"
        @preference_id = nil
      end
    rescue => e
      Rails.logger.error "Mercado Pago Error: #{e.message}\n#{e.backtrace.join("\n")}"
      flash.now[:error] = "Error al procesar el pago: #{e.message}"
      @preference_id = nil
    end
  end

  def new
    @donation = Donation.new
  end

  def create
    @donation = current_user.donations.new(donation_params)
    
    if @donation.save
      redirect_to donations_path, notice: '¡Gracias por tu donación! El administrador la revisará pronto.'
    else
      render :new
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