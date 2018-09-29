class Quotation < ApplicationRecord
  belongs_to :exchange_rate
  validates :based_requested_amount, presence: true
end
