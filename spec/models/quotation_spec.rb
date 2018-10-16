require 'rails_helper'
require './spec/shared/quotations'

RSpec.describe Quotation, type: :model do

  include_context 'quotations'

  describe 'validations' do
    it "validates" do
      is_expected.to belong_to :exchange_rate
      is_expected.to validate_presence_of(:based_requested_amount)
      is_expected.to validate_numericality_of(:based_requested_amount).is_greater_than(0)
    end
  end

  describe 'currency helper methods' do
    it 'should store currency exchange rate' do
      expect(quotation.current_exchange_rate).to eq(0.8)
    end

    it 'should calculate converted total' do
      expect(quotation.converted_total).to eq(80.00)
    end

  end

  describe 'currency helper methods' do
    it 'should return local currency code of converted currency' do
      expect(quotation.local_currency_code).to eq('GBP')
    end

    it 'should return base currency' do
      expect(quotation.base_currency.country_code).to eq('USD')
    end

    it 'should return converted currency' do
      expect(quotation.converted_currency.country_code).to eq('GBP')
    end

    it 'should format the total' do
      expect(quotation.formatted_total).to eq('£80.00')
    end
  end
end
