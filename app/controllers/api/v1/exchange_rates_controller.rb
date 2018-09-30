module Api::V1
  class ExchangeRatesController < ApplicationController
    def create
      render json: {success: true}
    end
  end
end
