class Order < ApplicationRecord

  belongs_to :user
  belongs_to :quotation
  validates :user_id,:quotation_id, presence: true
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

  def to_json(*)
    JSON.dump({
      base_purchase_amount: Money.new(quotation.based_requested_amount*100, base_currency.country_code).format,
      base_currency: base_currency.country_code,
      converted_currency: converted_currency.country_code,
      total_value: purchase_amount,
      formatted_value: Money.new(purchase_amount*100, converted_currency.country_code).format
    })
  end

end
