class ExchangeRate < ApplicationRecord
  belongs_to :base_currency, :class_name => 'Currency'
  belongs_to :converted_currency, :class_name => 'Currency'
  has_many :quotations
  has_many :orders

  validates :rate, presence: true

  # EXCHANGE RATES ARE DISPLAYED AS ATTRIBTUTES OF A CURRENCY
  def conversion_rate
    {country: converted_currency.country_code, rate: rate}
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
