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
      #
      it "should incremeent the number of quotations" do
        expect(ExchangeRate.count).to eq(1)
      end
      #
      # it "should calculate converted total" do
      #   expect(JSON.parse(response.body)["converted_total"]).to eq(80)
      #   expect(JSON.parse(response.body)["formatted_total"]).to eq('£80.00')
      # end

    end

  end
end
