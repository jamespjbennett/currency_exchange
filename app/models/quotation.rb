class Quotation < ApplicationRecord
  belongs_to :exchange_rate
  validates :based_requested_amount, presence: true
  after_create :calculate_converted_total

  def calculate_converted_total
    update(converted_total: based_requested_amount * exchange_rate.rate)
  end
  
end
