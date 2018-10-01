class User < ApplicationRecord
  # ASSOSCIATIONS
  has_many :orders

  # LIST THE USERS AVAILABLE CURRENCY THEY HAVE PURCHASED
  def available_currency
    # GROUP THE ORDER BY THE CURRENCY, AND TOTAL THE AMOUNT FOR THAT CURRENCY
    grouped_orders = orders.group_by(&:converted_currency)
    grouped_orders.map{|c| {c[0].denomination => c[1].map(&:purchase_amount).reduce(:+)}}
  end

  def to_json(*)
    JSON.dump({
      name: name,
      orders: orders.map(&:to_json),
      available_currency: available_currency,
    })
  end
end
