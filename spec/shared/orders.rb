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

  let(:exchange_rate_2){
    create(:exchange_rate, base_currency_id: converted_currency.id, converted_currency_id: base_currency.id, rate: 1.2)
  }

  let(:quotation){
    create(:quotation, based_requested_amount: 100, exchange_rate_id: exchange_rate.id)
  }

  let(:quotation_2){
    create(:quotation, based_requested_amount: 100, exchange_rate_id: exchange_rate_2.id)
  }

  let(:user){
      create(:user, name: 'test')
  }

  let(:order){
      create(:order, quotation_id: quotation.id, user_id: user.id)
  }
  let(:order_2){
      create(:order, quotation_id: quotation_2.id, user_id: user.id)
  }
end
