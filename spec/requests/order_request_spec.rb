require "rails_helper"
require './spec/shared/currencies'
require './spec/shared/orders'
RSpec.describe "Order Requests", :type => :request do

  describe 'create order' do

    include_context 'orders'
    #
    # before(:each) do
    #   @exchange_rate = create(:exchange_rate, base_currency_id: base_currency.id, converted_currency_id: converted_currency.id, rate: 0.8)
    #   @quotation = create(:quotation, based_requested_amount: 100, exchange_rate_id: @exchange_rate.id)
    #   @user = create(:user)
    # end

    let(:valid_attributes) { {quotation_id: quotation.id, user_id: user.id} }
    let(:invalid_attributes_1) { {quotation_id: quotation.id} }
    let(:invalid_attributes_2) { {quotation_id: 100, user_id: user.id} }

    context 'when the request is valid' do
      before { post '/api/v1/orders.json', params: valid_attributes }

      it "should make the request successfully" do
        expect(response).to be_ok
      end

      it "should incremeent the number of orders" do
        expect(Order.count).to eq(1)
      end

      it "should transfer total from quotation" do
        expect(json_response["total_value"]).to eq(quotation.converted_total)
      end

      it 'should return copied attributes from associated quotation' do
        expect(json_response["base_currency"]).to eq('USD')
        expect(json_response["converted_currency"]).to eq('GBP')
      end

      it 'should format the total into converted currency' do
        expect(json_response["formatted_value"]).to eq('£80.00')
      end
    end

    context 'when the request is invalid' do
      it 'should validate user exists' do
        post '/api/v1/orders.json', params: invalid_attributes_1
        expect(json_response["errors"]).to_not eq(nil)
        expect(json_response["errors"].values).to include(["must exist"])
      end

      it 'should validate quotation exists' do
        post '/api/v1/orders.json', params: invalid_attributes_1
        expect(json_response["errors"]).to_not eq(nil)
        expect(json_response["errors"].values).to include(["must exist"])
      end

      it 'should validate exchange rate is the same as quotation' do
        quotation_2 = create(:quotation, based_requested_amount: 100, exchange_rate_id: exchange_rate.id)
        exchange_rate.update(rate: 0.9)
        post '/api/v1/orders.json', params: {quotation_id: quotation_2.id}
        expect(json_response["errors"]).to_not eq(nil)
        expect(json_response["errors"].values).to include(["exchange rate has changed. Please create new quotation with adjusted exchange rate."])
      end

    end

  end

  describe 'list orders' do
      include_context 'orders'

      it "should list all orders" do
        create(:order, user_id: user.id, quotation_id: quotation.id)
        create(:order, user_id: user.id, quotation_id: quotation_2.id)
        get '/api/v1/orders.json'
        expect(json_response.length).to eq(2)
      end

  end

  describe 'display order' do
    include_context 'orders'
    
    before { get "/api/v1/orders/#{order.id}.json" }

    it "should list be ok" do
      expect(response).to be_ok
    end
    it "should return valid order" do
      expect(json_response["total_value"]).to eq(80.0)
      expect(json_response["base_currency"]).to eq("USD")
      expect(json_response["base_purchase_amount"]).to eq("$100.00")
    end

  end

  def json_response
    JSON.parse(response.body)
  end

end
