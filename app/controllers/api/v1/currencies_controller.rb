module Api::V1
  class CurrenciesController < ApplicationController
    before_action :set_currency, only: [:show]

    def index
      @currencies = Currency.all
      render json: @currencies.map(&:to_json)
    end

    def show
      render json: @currency.to_json
    end

    private

    def set_currency
      @currency = Currency.find_by(country_code: params[:id])
    end
  end
end
