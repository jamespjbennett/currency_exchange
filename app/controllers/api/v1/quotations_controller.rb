module Api::V1
  class QuotationsController < ApplicationController
    def create
      @quotation = Quotation.create(quotation_params)
      render json: @quotation
    end

    private

    def quotation_params
      # whitelist params
      params.permit(:based_requested_amount, :exchange_rate_id)
    end
  end
end
