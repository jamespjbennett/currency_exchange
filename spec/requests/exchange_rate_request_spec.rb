require "rails_helper"

RSpec.describe "Exchange Rate Requests", :type => :request do

  describe 'create exchange rate' do
    before(:each) do
      @base_currency = create(:currency, country_code: 'USD', denomination: '$')
      @converted_currency = create(:currency, country_code: 'GBP', denomination: '£')
    end

    let(:valid_attributes) { {base_currency_id: @base_currency.id, converted_currency_id: @converted_currency.id, rate: 0.8 } }

    context 'when the request is valid' do
      before { post '/api/v1/exchange_rates.json', params: valid_attributes }

      it "should make the request successfully" do
        expect(response).to be_ok
      end

      it "should incremeent the number of quotations" do
        expect(ExchangeRate.count).to eq(1)
      end

    end

  end

  describe 'update exchange rates' do
    before(:each) do
      base_currency = create(:currency, country_code: 'USD', denomination: '$')
      converted_currency_id = create(:currency, country_code: 'GBP', denomination: '£')
      @exchange_rate = create(:exchange_rate, base_currency_id: base_currency.id, converted_currency_id: converted_currency_id.id, rate: 0.8)
    end

    let(:valid_attributes) { {rate: 0.9 } }

    context 'when the request is valid' do
      before { patch "/api/v1/exchange_rates/#{@exchange_rate.id}.json", params: valid_attributes }

      it "should make the request successfully" do
        expect(response).to be_ok
      end

      it "should return updated attribute correctly" do
        expect(JSON.parse(response.body)["rate"]).to eq(0.9)
      end
    end

  end
end
