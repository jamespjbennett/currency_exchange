class ExchangeRate < ApplicationRecord
  belongs_to :base_currency, :class_name => 'Currency'
  belongs_to :converted_currency, :class_name => 'Currency'
  has_many :quotations
  has_many :orders

  validates :rate, presence: true
  validate :duplicate_currencies

  # EXCHANGE RATES ARE DISPLAYED AS ATTRIBTUTES OF A CURRENCY
  def conversion_rate
    {country: converted_currency.country_code, rate: rate}
  end

  # VALIDATE THE 2 PROVIDED CURRENCIES ARENT THE SAME
  def duplicate_currencies
    if base_currency_id == converted_currency_id
      errors.add(:converted_currency_id, "base and converted currency must be different")
    end
  end

  def to_json(*)
    {
      rate: rate,
      conversion_rate: conversion_rate,
      base_currency: base_currency.country_code,
      converted_currency: converted_currency.country_code,
    }
  end

end
