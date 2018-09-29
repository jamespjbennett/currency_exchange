require "rails_helper"

RSpec.describe "Currency Requests", :type => :request do

  it "creates lists currency objects" do
    get "/api/v1/currencies.json"
    expect(response).to be_ok

    # post "/widgets", :widget => {:name => "My Widget"}
    #
    # expect(response).to redirect_to(assigns(:widget))
    # follow_redirect!
    #
    # expect(response).to render_template(:show)
    # expect(response.body).to include("Widget was successfully created.")
  end

  # it "does not render a different template" do
  #   get "/widgets/new"
  #   expect(response).to_not render_template(:show)
  # end
end
