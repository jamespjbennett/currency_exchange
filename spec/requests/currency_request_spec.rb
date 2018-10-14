require "rails_helper"

RSpec.describe "Currency Requests", :type => :request do

  describe 'currencies#index' do
    before(:each) do
      2.times {create(:currency)}
      get "/api/v1/currencies.json"
    end
    it "should make the request successfully" do
      expect(response).to be_ok
    end
    it "should return the currency objects" do
      expect(json_response.length).to eq(2)
    end
  end

  describe 'currencies#show' do
    before(:each) do
      @currency = create(:currency)
      get "/api/v1/currencies/#{@currency.country_code}"
    end
    it "should make the request successfully" do
      expect(response).to be_ok
    end
    it "should return the currency object" do
      expect(json_response['country_code']).to eq(@currency.country_code)
    end
  end

  describe 'error handling' do
    it 'should return error that currency isnt found' do
      get "/api/v1/currencies/incorrect"
      expect(json_response["errors"]).to_not eq(nil)
      expect(json_response["errors"].values).to include(["currency not recognized"])
    end
  end

  def json_response
    JSON.parse(response.body)
  end

end
