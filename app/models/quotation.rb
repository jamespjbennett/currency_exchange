class Quotation < ApplicationRecord
  include ActiveSupport::NumberHelper
  belongs_to :exchange_rate
  validates :based_requested_amount, presence: true
  after_create :calculate_converted_total

  def calculate_converted_total
    update(converted_total: based_requested_amount * exchange_rate.rate)
  end

  def local_currency_code
    exchange_rate.converted_currency.country_code
  end

  def base_currency
    exchange_rate.base_currency
  end

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

  # t.float :based_requested_amount
  # t.float :converted_total
  # t.integer :exchange_rate_id

end
