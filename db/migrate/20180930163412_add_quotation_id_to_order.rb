class AddQuotationIdToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :quotation_id, :integer
  end
end
