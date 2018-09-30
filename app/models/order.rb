class Order < ApplicationRecord
  include ActiveSupport::NumberHelper
  belongs_to :exchange_rate
  belongs_to :user
  validates :user_id,:exchange_rate_id, :purchase_amount, presence: true

end
