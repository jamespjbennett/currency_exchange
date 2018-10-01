RSpec.shared_context "orders" do
  let(:base_currency) {
    create(:currency, country_code: 'USD', denomination: '$')
  }

  let(:converted_currency) {
    create(:currency, country_code: 'GBP', denomination: '£')
  }
  let(:exchange_rate){
    create(:exchange_rate, base_currency_id: base_currency.id, converted_currency_id: converted_currency.id, rate: 0.8)
  }

  let(:quotation){
    create(:quotation, based_requested_amount: 100, exchange_rate_id: exchange_rate.id)
  }

  let(:user){
      create(:user, name: 'test')
  }

  let(:order){
      create(:order, quotation_id: quotation.id, user_id: user.id)
  }
end
