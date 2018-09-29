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
      expect(JSON.parse(response.body).length).to eq(2)
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
      expect(JSON.parse(response.body)['id']).to eq(@currency.id)
    end
  end

    # post "/widgets", :widget => {:name => "My Widget"}
    #
    # expect(response).to redirect_to(assigns(:widget))
    # follow_redirect!
    #
    # expect(response).to render_template(:show)
    # expect(response.body).to include("Widget was successfully created.")


  # it "does not render a different template" do
  #   get "/widgets/new"
  #   expect(response).to_not render_template(:show)
  # end
end
