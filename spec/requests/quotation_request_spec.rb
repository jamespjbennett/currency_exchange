require "rails_helper"

RSpec.describe "Quotation Requests", :type => :request do

  describe 'create quotation' do
    before(:each) do
      base_currency = create(:currency, country_code: 'USD', denomination: '$')
      converted_currency_id = create(:currency, country_code: 'GBP', denomination: '£')
      @exchange_rate = create(:exchange_rate, base_currency_id: base_currency.id, converted_currency_id: converted_currency_id.id, rate: 1.2)
    end

    let(:valid_attributes) { { quotation: {based_requested_amount: 100, exchange_rate_id: @exchange_rate.id } }}

    context 'when the request is valid' do
      before { post '/api/v1/quotations.json', params: valid_attributes }

      it "should make the request successfully" do
        expect(response).to be_ok
      end

    end
    # it "should return the currency objects" do
    #   expect(JSON.parse(response.body).length).to eq(2)
    # end
  end

end
