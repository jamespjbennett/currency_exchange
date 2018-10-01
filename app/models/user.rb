class User < ApplicationRecord
  has_many :orders


  def available_currency
    grouped_orders = orders.group_by(&:converted_currency)
    grouped_orders.map{|currency| {currency[0].denomination => currency[1].map(&:purchase_amount).reduce(:+)}}
  end

  def to_json(*)
    JSON.dump({
      name: name,
      orders: orders.map(&:to_json),
      available_currency: available_currency,
    })
  end
end
