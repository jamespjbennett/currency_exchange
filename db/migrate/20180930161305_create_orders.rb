class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :exchange_rate_id
      t.float :purchase_amount
      t.timestamps
    end
  end
end
