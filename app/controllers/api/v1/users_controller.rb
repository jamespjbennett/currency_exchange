module Api::V1
  class UsersController < ApplicationController
    before_action :set_currency, only: [:show]


    # def show
    #   render json: @currency.to_json
    # end

    private

    # def set_currency
    #   @currency = Currency.find_by(country_code: params[:id])
    # end
  end
end
