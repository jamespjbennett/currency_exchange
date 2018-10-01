class Quotation < ApplicationRecord
  include ActiveSupport::NumberHelper
  belongs_to :exchange_rate
  validates :based_requested_amount, presence: true
  validates :based_requested_amount, numericality: { greater_than: 0 }
  after_create :calculate_converted_total

  # CALCULATED THE QUOTATION AMOUNT BASED ON THE BASED AMOUNT AND EXCHANGE RATE
  def calculate_converted_total
    update(converted_total: based_requested_amount * exchange_rate.rate)
  end

  # GET THE COUNTRY CODE OF THE CONVERTED CURRENCY
  def local_currency_code
    exchange_rate.converted_currency.country_code
  end

  # THE CURRENCY TO BE CONVERTED FROM
  def base_currency
    exchange_rate.base_currency
  end

  # THE CURRENCY TO BE CONVERTED TO
  def converted_currency
    exchange_rate.converted_currency
  end

  def formatted_total
    Money.new(converted_total*100, local_currency_code).format
  end

  def to_json(*)
    JSON.dump({
      base_currency: base_currency.country_code,
      converted_currency: converted_currency.country_code,
      requested_base_currency_amount: based_requested_amount,
      converted_total: converted_total,
      formatted_total: formatted_total,
    })
  end

end
