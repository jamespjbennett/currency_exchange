module Api::V1
  class ExchangeRatesController < ApplicationController
    def create
      @exchange_rate = ExchangeRate.create(exchange_rate_params)
      render json: @exchange_rate.to_json
    end

    private
    def exchange_rate_params
      # whitelist params
      params.permit(:base_currency_id, :converted_currency_id, :rate)
    end

  end
end
