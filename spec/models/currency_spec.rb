require 'rails_helper'

RSpec.describe Currency, type: :model do
  it { is_expected.to have_many(:base_currency_rates) }
  it { is_expected.to have_many(:converted_currency_rates) }
end
