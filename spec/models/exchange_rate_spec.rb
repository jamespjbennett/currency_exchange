require 'rails_helper'

RSpec.describe ExchangeRate, type: :model do
  it "validates" do
    is_expected.to belong_to :base_currency
    is_expected.to belong_to :converted_currency
    is_expected.to have_many :quotations
    is_expected.to have_many :orders
    is_expected.to validate_presence_of(:rate)
  end
end
