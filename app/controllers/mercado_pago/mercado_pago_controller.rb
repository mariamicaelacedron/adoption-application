require 'mercadopago'

module MercadoPago
    class MercadoPagoController < ApplicationController
        skip_before_action :verify_authenticity_token
        def create_payment
            amount = params[:amount].to_f
            sdk = Mercadopago::SDK.new(ENV['MERCADOPAGO_ACCESS_TOKEN'])
          
            base_url = ENV['APP_HOST'] || "https://#{request.host}:#{request.port}"
            
            preference_data = {
              items: [{
                title: "Donación a Salvando Patitas",
                unit_price: amount,
                quantity: 1,
                currency_id: "ARS"
              }],
              back_urls: {
                success: "#{base_url}/mercado_pago/success",
                failure: "#{base_url}/mercado_pago/failure",
                pending: "#{base_url}/mercado_pago/pending"
              },
              auto_return: "all",
              binary_mode: true
            }
          
            preference_response = sdk.preference.create(preference_data)
          
            if preference_response[:status] == 201
              redirect_to preference_response[:response]['init_point'], allow_other_host: true
            else
              error_msg = preference_response[:response].to_json
              redirect_to donations_path, alert: "Error MP: #{error_msg}"
            end
          end

      def success
        payment_id = params[:payment_id] || params[:preference_id]
        amount = params[:amount] || 100.0
  
        if payment_id.present?
          Donation.create!(
            amount: amount,
            payment_id: payment_id
          )
          redirect_to donations_path, notice: '¡Donación exitosa!'
        else
          redirect_to donations_path, alert: 'No se pudo verificar el pago'
        end
      end
  
      def failure
        redirect_to donations_path, alert: 'Pago fallido'
      end
  
      def pending
        redirect_to donations_path, notice: 'Pago pendiente'
      end
  
      def notification
        payment_id = params[:data][:id] if params[:data].present?
        
        if payment_id
          head :ok
        else
          head :unprocessable_entity
        end
      end
    end
  end