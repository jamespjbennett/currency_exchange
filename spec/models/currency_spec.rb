require 'rails_helper'

RSpec.describe Currency, type: :model do
  it "validates" do
    is_expected.to have_many :base_currency_rates
    is_expected.to have_many :converted_currency_rates
    is_expected.to validate_presence_of(:country_code)
    is_expected.to validate_presence_of(:denomination)
  end

  it 'returns correct json object' do
    base_currency = create(:currency, country_code: 'USD', denomination: '$')
    converted_currency_id = create(:currency, country_code: 'GBP', denomination: '£')
    create(:exchange_rate, base_currency_id: base_currency.id, converted_currency_id: converted_currency_id.id, rate: 1.2)
    expect(JSON.parse( base_currency.to_json)["rates"][0].keys).to contain_exactly('country', 'rate')
    expect(JSON.parse( base_currency.to_json)["rates"][0].values).to contain_exactly('GBP', 1.2)

  end
end
