require "rails_helper"

RSpec.describe "Quotation Requests", :type => :request do

  describe 'create quotation' do
    before(:each) do
      base_currency = create(:currency, country_code: 'USD', denomination: '$')
      converted_currency_id = create(:currency, country_code: 'GBP', denomination: '£')
      @exchange_rate = create(:exchange_rate, base_currency_id: base_currency.id, converted_currency_id: converted_currency_id.id, rate: 0.8)
    end

    let(:valid_attributes) { {based_requested_amount: 100, exchange_rate_id: @exchange_rate.id } }

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

    end

    def json_response
      JSON.parse(response.body)
    end

  end

end
