require "rails_helper"
require './spec/shared/orders'

RSpec.describe "Exchange Rate Requests", :type => :request do

  describe 'users#show' do

    include_context 'orders'

    context "return correct attributes" do
      before { get "/api/v1/users/#{user.id}.json" }
      it "should make the request successfully" do
        expect(response).to be_ok
      end

      it "should display the correct user id" do
        expect(json_response["name"]).to eq('test')
      end

      it "should display the users orders" do
        # FOR SOME REASON THIS ONLY WORKED IF I MAKE THE REQUEST AGAIN?
        user.orders << order
        get "/api/v1/users/#{user.id}.json"
        expect(json_response["orders"].length).to eq(1)
      end

    end
  end

  def json_response
    JSON.parse(response.body)
  end

end
