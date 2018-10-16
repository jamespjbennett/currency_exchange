class DuplicateCurrencyValidator < ActiveModel::Validator
  def validate(record)
    if record.base_currency_id == record.converted_currency_id
      record.errors.add(:converted_currency_id, "base and converted currency must be different")
    end
  end
end
