class ExchangeRate < ApplicationRecord
  belongs_to :base_currency, :class_name => 'Currency'
  belongs_to :converted_currency, :class_name => 'Currency'
  has_many :quotations
  validates :rate, presence: true

end
