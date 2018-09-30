class Order < ApplicationRecord
  include ActiveSupport::NumberHelper
  belongs_to :exchange_rate
  belongs_to :user
end
