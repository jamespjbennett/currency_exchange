class Currency < ApplicationRecord
  has_many :base_currency_rates, :class_name => 'ExchangeRate', :foreign_key => 'base_currency_id'
  has_many :converted_currency_rates, :class_name => 'ExchangeRate', :foreign_key => 'converted_currency_id'
  has_many :quotations, through: :exchange_rates
  validates :country_code, :denomination, presence: true

  def rates
    base_currency_rates.map(&:conversion_rate)
  end

  def to_json(*)
    JSON.dump({
      country_code: country_code,
      denomination: denomination,
      rates: rates,
    })
  end

end
