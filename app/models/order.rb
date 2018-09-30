class Order < ApplicationRecord
  include ActiveSupport::NumberHelper
  belongs_to :exchange_rate
  belongs_to :user
  belongs_to :quotation
  validates :user_id,:exchange_rate_id, :quotation_id, presence: true
  after_create :transfer_purchase_amount

  def transfer_purchase_amount
    update(purchase_amount: quotation.converted_total)
  end

end
