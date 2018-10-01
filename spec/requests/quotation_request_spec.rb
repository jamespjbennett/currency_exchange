require "rails_helper"
require './spec/shared/currencies'
RSpec.describe "Quotation Requests", :type => :request do

  describe 'create quotation' do

    include_context 'currencies'

    before(:each) do
      @exchange_rate = create(:exchange_rate, base_currency_id: base_currency.id, converted_currency_id: converted_currency.id, rate: 0.8)
    end

    let(:valid_attributes) { {based_requested_amount: 100, exchange_rate_id: @exchange_rate.id } }
    let(:invalid_attributes_1) { {based_requested_amount: 0, exchange_rate_id: @exchange_rate.id } }
    let(:invalid_attributes_2) { {based_requested_amount: 100, exchange_rate_id:10 } }

    context 'when the request is valid' do
      before { post '/api/v1/quotations.json', params: valid_attributes }

      it "should make the request successfully" do
        expect(response).to be_ok
      end

      it "should incremeent the number of quotations" do
        expect(Quotation.count).to eq(1)
      end

      it "should calculate converted total" do
        expect(json_response["converted_total"]).to eq(80)
        expect(json_response["formatted_total"]).to eq('£80.00')
      end

      it "should populate currenct exchange rate" do
        expect(json_response["current_exchange_rate"]).to eq(@exchange_rate.rate)
      end

    end


    context 'when the request is invalid' do
      it "should return error if requested amount is 0" do
        post '/api/v1/quotations.json', params: invalid_attributes_1
        expect(json_response["errors"]).to_not eq(nil)
        expect(json_response["errors"].values).to include(["must be greater than 0"])
      end
      it "should return error if exchange rate doesnt exist" do
        post '/api/v1/quotations.json', params: invalid_attributes_2
        expect(json_response["errors"]).to_not eq(nil)
        expect(json_response["errors"].values).to include(["must exist"])
      end
    end

    def json_response
      JSON.parse(response.body)
    end

  end

  describe 'show quotation' do

  end
end
