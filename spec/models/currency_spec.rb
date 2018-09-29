require 'rails_helper'

RSpec.describe Currency, type: :model do
  it { should have_many(:base_currency_rates) }
  it { should have_many(:converted_currency_rates) }
end
