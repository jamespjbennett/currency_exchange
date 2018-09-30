module Api::V1
  class QuotationsController < ApplicationController

    def create
      @quotation = Quotation.create(quotation_params)
      if @quotation.valid?
        render json: @quotation.to_json
      else
        render json: {errors: @quotation.errors}
      end
    end

    def show
      render json: @quotation
    end

    private

    def quotation_params
      # whitelist params
      params.permit(:based_requested_amount, :exchange_rate_id)
    end

    def set_quotation
      @quotation = Quotation.find(params[:id])
    end
  end
end
