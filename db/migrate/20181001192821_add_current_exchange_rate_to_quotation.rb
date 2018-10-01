class AddCurrentExchangeRateToQuotation < ActiveRecord::Migration[5.2]
  def change
    add_column :quotations, :current_exchange_rate, :float
  end
end
