class Currency < ApplicationRecord
  has_many :base_currency_rates, :class_name => 'ExchangeRate', :foreign_key => 'base_currency_id'
  has_many :converted_currency_rates, :class_name => 'ExchangeRate', :foreign_key => 'converted_currency_id'
  validates :country_code, :denomination, presence: true
end
