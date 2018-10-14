require 'rails_helper'
require './spec/shared/invalid_exchange_rates'

RSpec.describe ExchangeRate, type: :model do

  include_context 'invalid_exchange_rates'

  it "validates and correctly applies relationships" do
    is_expected.to belong_to :base_currency
    is_expected.to belong_to :converted_currency
    is_expected.to have_many :quotations
    is_expected.to have_many :orders
    is_expected.to validate_presence_of(:rate)
  end

  it 'doesnt save with invalid attributes' do
    expect(invalid_exchange_rate_no_base.save).to eq(false)
    expect(invalid_exchange_rate_no_converted.save).to eq(false)
    expect(invalid_exchange_rate_dupes.save).to eq(false)
  end
end
