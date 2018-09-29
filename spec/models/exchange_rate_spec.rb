require 'rails_helper'

RSpec.describe ExchangeRate, type: :model do
  it { is_expected.to belong_to(:base_currency) }
  it { is_expected.to belong_to(:converted_currency) }
end
