require "rails_helper"

RSpec.describe "Exchange Rate Requests", :type => :request do

  describe 'exchange_rates#create' do
    before(:each) do
      2.times {create(:currency)}
      get "/api/v1/currencies.json"
    end
    it "should make the request successfully" do
      expect(response).to be_ok
    end
    # it "should return the currency objects" do
    #   expect(JSON.parse(response.body).length).to eq(2)
    # end
  end

  # describe 'currencies#show' do
  #   before(:each) do
  #     @currency = create(:currency)
  #     get "/api/v1/currencies/#{@currency.country_code}"
  #   end
  #   it "should make the request successfully" do
  #     expect(response).to be_ok
  #   end
  #   it "should return the currency object" do
  #     expect(JSON.parse(response.body)['country_code']).to eq(@currency.country_code)
  #   end
  # end
end
