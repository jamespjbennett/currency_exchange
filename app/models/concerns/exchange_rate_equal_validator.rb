class ExchangeRateEqualValidator < ActiveModel::Validator
  def validate(record)
    if record.quotation
      exchange_rate_equal = (record.quotation.exchange_rate.rate ==  record.quotation.current_exchange_rate)
      if !exchange_rate_equal
        record.errors.add(:quotation_id, "exchange rate has changed. Please create new quotation with adjusted exchange rate.")
      end
    end
  end
end
