class CreateExchangeRates < ActiveRecord::Migration[5.2]
  def change
    create_table :exchange_rates do |t|
      t.float :rate
      t.references :base_currency
      t.references :converted_currency
      t.timestamps
    end
  end
end
