require 'rails_helper'

RSpec.describe Order, type: :model do
  it "validates" do
    is_expected.to belong_to :exchange_rate
    is_expected.to belong_to :user
    is_expected.to validate_presence_of(:user_id)
    is_expected.to validate_presence_of(:exchange_rate_id)
    is_expected.to validate_presence_of(:quotation_id)
  end
end
