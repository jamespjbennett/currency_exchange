RSpec.shared_context "invalid_exchange_rates" do
  let(:base_currency) {
    create(:currency, country_code: 'USD', denomination: '$')
  }

  let(:converted_currency) {
    create(:currency, country_code: 'GBP', denomination: '£')
  }
  let(:invalid_exchange_rate_no_base){
    build(:exchange_rate, converted_currency_id: converted_currency.id, rate: 0.8)
  }
  let(:invalid_exchange_rate_no_converted){
    build(:exchange_rate, base_currency_id: base_currency.id, rate: 0.8)
  }
  let(:invalid_exchange_rate_no_rate){
    build(:exchange_rate, base_currency_id: base_currency.id, converted_currency_id: converted_currency.id)
  }
  let(:invalid_exchange_rate_dupes){
    build(:exchange_rate, base_currency_id: base_currency.id, converted_currency_id: base_currency.id,  rate: 0.8)
  }
end
