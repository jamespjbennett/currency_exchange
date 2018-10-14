require "rails_helper"
require './spec/shared/currencies'
require './spec/shared/orders'
require './spec/shared/invalid_exchange_rates'

RSpec.describe "Exchange Rate Requests", :type => :request do

  include_context 'currencies'
  include_context 'orders'
  include_context 'invalid_exchange_rates'

  describe 'create exchange rate' do

    let(:valid_attributes) { {base_currency_id: base_currency.id, converted_currency_id: converted_currency.id, rate: 0.8 } }
    let(:invalid_attributes_no_converted) { {base_currency_id: base_currency.id, rate: 0.8 } }
    let(:invalid_attributes_no_base_currency) { {converted_currency_id: converted_currency.id, rate: 0.8 } }
    let(:invalid_attributes_no_rate) { {base_currency_id: base_currency.id, converted_currency_id: converted_currency.id} }
    let(:invalid_attributes_dupe_currencies) { {base_currency_id: base_currency.id, converted_currency_id: base_currency.id, rate: 0.8 } }

    context 'when the request is valid' do
      before { post '/api/v1/exchange_rates.json', params: valid_attributes }

      it "should make the request successfully" do
        expect(response).to be_ok
      end

      it "should incremeent the number of quotations" do
        expect(ExchangeRate.count).to eq(1)
      end
    end

    context 'when the request is not valid' do
      it 'should return error if no base_currency_id' do
        post '/api/v1/exchange_rates.json', params: invalid_attributes_no_base_currency
        expect(json_response["errors"]).to_not eq(nil)
        expect(json_response["errors"].values).to include(['must exist'])
      end
      it 'should return error if no converted_currency_id' do
        post '/api/v1/exchange_rates.json', params: invalid_attributes_no_converted
        expect(json_response["errors"]).to_not eq(nil)
        expect(json_response["errors"].values).to include(['must exist'])
      end
      it 'should return error if no rate' do
        post '/api/v1/exchange_rates.json', params: invalid_attributes_no_rate
        expect(json_response["errors"]).to_not eq(nil)
        expect(json_response["errors"].values).to include(["can't be blank"])
      end
      it 'should return error if base_currency and exchange currency are the same' do
        post '/api/v1/exchange_rates.json', params: invalid_attributes_dupe_currencies
        expect(json_response["errors"]).to_not eq(nil)
        expect(json_response["errors"].values).to include(["base and converted currency must be different"])
      end
    end

  end

  describe 'update exchange rates' do

    let(:valid_attributes) { {rate: 0.9 } }

    context 'when the request is valid' do
      before { patch "/api/v1/exchange_rates/#{exchange_rate.id}.json", params: valid_attributes }

      it "should make the request successfully" do
        expect(response).to be_ok
      end

      it "should return updated attribute correctly" do
        expect(json_response["rate"]).to eq(0.9)
      end
    end
  end

  describe 'list exchange rates' do
    before(:each) do
      get "/api/v1/exchange_rates.json"
      @exchange_rate = create(:exchange_rate, base_currency_id: base_currency.id, converted_currency_id: converted_currency.id, rate: 0.8)
      @exchange_rate_2 = create(:exchange_rate, base_currency_id: converted_currency.id, converted_currency_id: base_currency.id, rate: 0.8)
    end

    before { get "/api/v1/exchange_rates.json" }

    it "should make the request successfully" do
      expect(response).to be_ok
    end

    it "should make the request successfully" do
      expect(json_response.length).to eq(2)
    end
  end


  def json_response
    JSON.parse(response.body)
  end
end
