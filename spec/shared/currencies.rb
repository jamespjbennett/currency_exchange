RSpec.shared_context "currencies" do
  let(:base_currency) {
    create(:currency, country_code: 'USD', denomination: '$')
  }

  let(:converted_currency) {
    create(:currency, country_code: 'GBP', denomination: '£')
  }

end
