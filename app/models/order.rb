class Order < ApplicationRecord

  belongs_to :user
  belongs_to :quotation
  validates :user_id,:quotation_id, presence: true
  validate :exchange_rate_hasnt_changed
  after_create :transfer_purchase_attributes

  # AFTER CREATION - COPY THE AMOUNT OVER FROM THE ATTACHED QUOTATION
  def transfer_purchase_attributes
    update(purchase_amount: quotation.converted_total)
  end

  # REFERENCE THE BASE CURRENCY FROM THE QUOTATION
  def base_currency
    quotation.base_currency
  end

  # REFERENCE THE CONVERTED CURRENCY FROM THE QUOTATION
  def converted_currency
    quotation.converted_currency
  end

  # CUSTOM VALIDATION - MAKE SURE EXCHANGE RATE IS THE SAME AS WHEN QUOTATION WAS CREATED
  def exchange_rate_hasnt_changed
    if quotation
      exchange_rate_equal = (quotation.exchange_rate.rate ==  quotation.current_exchange_rate)
      if !exchange_rate_equal
        errors.add(:quotation_id, "exchange rate has changed. Please create new quotation with adjusted exchange rate.")
      end
    end
  end

  def to_json(*)
    {
      base_purchase_amount: Money.new(quotation.based_requested_amount*100, base_currency.country_code).format,
      base_currency: base_currency.country_code,
      converted_currency: converted_currency.country_code,
      total_value: purchase_amount,
      formatted_value: Money.new(purchase_amount*100, converted_currency.country_code).format
    }
  end

end
