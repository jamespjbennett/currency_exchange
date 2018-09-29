class CreateCurrencies < ActiveRecord::Migration[5.2]
  def change
    create_table :currencies do |t|
      t.string :country_code
      t.string :denomination

      t.timestamps
    end
  end
end
