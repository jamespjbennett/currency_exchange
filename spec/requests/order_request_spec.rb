require "rails_helper"
require './spec/shared/currencies'
RSpec.describe "Order Requests", :type => :request do

  describe 'create order' do

    include_context 'currencies'

    before(:each) do
      @exchange_rate = create(:exchange_rate, base_currency_id: base_currency.id, converted_currency_id: converted_currency.id, rate: 0.8)
      @quotation = create(:quotation, based_requested_amount: 100, exchange_rate_id: @exchange_rate.id)
      @user = create(:user)
    end

    let(:valid_attributes) { {quotation_id: @quotation.id, user_id: @user.id} }
    let(:invalid_attributes_1) { {quotation_id: @quotation.id} }
    let(:invalid_attributes_2) { {quotation_id: 100, user_id: @user.id} }

    context 'when the request is valid' do
      before { post '/api/v1/orders.json', params: valid_attributes }

      it "should make the request successfully" do
        expect(response).to be_ok
      end

      it "should incremeent the number of orders" do
        expect(Order.count).to eq(1)
      end

      it "should transfer total from quotation" do
        expect(json_response["total_value"]).to eq(@quotation.converted_total)
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
    end

  end

  describe 'list orders' do
      include_context 'currencies'
      before(:each) do
        @exchange_rate = create(:exchange_rate, base_currency_id: base_currency.id, converted_currency_id: converted_currency.id, rate: 0.8)
        @quotation = create(:quotation, based_requested_amount: 100, exchange_rate_id: @exchange_rate.id)
        @quotation2 = create(:quotation, based_requested_amount: 50, exchange_rate_id: @exchange_rate.id)
        @user = create(:user)
      end

      it "should list orders all orders" do
        create(:order, user_id: @user.id, quotation_id: @quotation.id)
        create(:order, user_id: @user.id, quotation_id: @quotation2.id)
        get '/api/v1/orders.json'
        expect(json_response.length).to eq(2)
      end

  end

  def json_response
    JSON.parse(response.body)
  end

end
