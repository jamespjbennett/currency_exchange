module Api::V1
  class OrdersController < ApplicationController

    def index
      @orders = Order.all
      render json: @orders.map(&:to_json)
    end

    def create
      @order = Order.create(order_params)
      if @order.valid?
        render json: @order.to_json
      else
        render json: {errors: @order.errors}
      end
    end

    private

    def order_params
      # whitelist params
      params.permit(:quotation_id, :user_id, :exchange_rate_id)
    end
  end
end
