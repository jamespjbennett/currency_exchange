require 'rails_helper'

RSpec.describe Currency, type: :model do
  it "validates" do
    is_expected.to have_many :base_currency_rates
    is_expected.to have_many :converted_currency_rates
  end
end
