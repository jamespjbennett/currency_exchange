require 'rails_helper'

RSpec.describe Quotation, type: :model do
  it "validates" do
    is_expected.to belong_to :exchange_rate
    is_expected.to validate_presence_of(:based_requested_amount)
    is_expected.to validate_presence_of(:exchange_rate_id)
  end
end
