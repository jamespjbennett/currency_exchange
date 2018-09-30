module Api::V1
  class ExchangeRatesController < ApplicationController
    before_action :set_exchange_rate, only: [:update]

    def create
      @exchange_rate = ExchangeRate.create(exchange_rate_params)
      render json: @exchange_rate
    end

    def update
      @exchange_rate.update(exchange_rate_params)
      render json: @exchange_rate
    end

    private

    def exchange_rate_params
      # whitelist params
      params.permit(:base_currency_id, :converted_currency_id, :rate)
    end

    def set_exchange_rate
      @exchange_rate = ExchangeRate.find(params[:id])
    end

  end
end