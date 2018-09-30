require "rails_helper"

RSpec.describe "Order Requests", :type => :request do

  describe 'create order' do
    before(:each) do
      base_currency = create(:currency, country_code: 'USD', denomination: '$')
      converted_currency_id = create(:currency, country_code: 'GBP', denomination: '£')
      @exchange_rate = create(:exchange_rate, base_currency_id: base_currency.id, converted_currency_id: converted_currency_id.id, rate: 0.8)
      @quotation = create(:quotation, based_requested_amount: 100, exchange_rate_id: @exchange_rate.id)
      @user = create(:user)
    end

    let(:valid_attributes) { {quotation_id: @quotation.id, user_id: @user.id, exchange_rate_id: @exchange_rate.id } }

    context 'when the request is valid' do
      before { post '/api/v1/orders.json', params: valid_attributes }

      it "should make the request successfully" do
        expect(response).to be_ok
      end
    #
      it "should incremeent the number of orders" do
        expect(Order.count).to eq(1)
      end
    #
    #   it "should calculate converted total" do
    #     expect(JSON.parse(response.body)["converted_total"]).to eq(80)
    #     expect(JSON.parse(response.body)["formatted_total"]).to eq('£80.00')
    #   end
    #
    end

  end

end
