class CreateQuotations < ActiveRecord::Migration[5.2]
  def change
    create_table :quotations do |t|
      t.float :based_requested_amount
      t.float :converted_total
      t.integer :exchange_rate_id
      t.timestamps
    end
  end
end
