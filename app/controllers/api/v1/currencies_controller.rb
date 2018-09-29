module Api::V1
  class CurrenciesController < ApplicationController
    def index
      @currencies = Currency.all
      render json: @currencies
    end
  end
end
