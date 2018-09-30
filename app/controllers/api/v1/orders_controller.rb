module Api::V1
  class OrdersController < ApplicationController

    def create
      render json: {success:true}
    end
    
  end
end
