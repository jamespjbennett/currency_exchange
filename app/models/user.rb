class User < ApplicationRecord
  has_many :orders

  def to_json(*)
    JSON.dump({
      name: name,
      orders: orders.map(&:to_json),
    })
  end
end
