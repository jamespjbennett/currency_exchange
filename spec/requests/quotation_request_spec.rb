require "rails_helper"

RSpec.describe "Quotation Requests", :type => :request do

  describe 'quotations#create' do
    before(:each) do
      post "/api/v1/quotations.json"
    end
    it "should make the request successfully" do
      expect(response).to be_ok
    end
    # it "should return the currency objects" do
    #   expect(JSON.parse(response.body).length).to eq(2)
    # end
  end

end
