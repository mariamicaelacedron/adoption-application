class MercadoPagoController < ApplicationController
  before_action :authenticate_user!

  def create_preference
    require 'net/http'
    require 'json'

    uri = URI('https://api.mercadopago.com/checkout/preferences')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path)
    request['Authorization'] = "Bearer #{ENV['MERCADOPAGO_ACCESS_TOKEN']}"
    request['Content-Type'] = 'application/json'

    request.body = {
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
      auto_return: "approved"
    }.to_json

    response = http.request(request)
    preference = JSON.parse(response.body)

    if preference["id"].present?
      redirect_to preference["init_point"], allow_other_host: true
    else
      redirect_to donations_path, alert: "Error al crear la preferencia de pago"
    end
  rescue => e
    redirect_to donations_path, alert: "Error al procesar el pago: #{e.message}"
  end
end 