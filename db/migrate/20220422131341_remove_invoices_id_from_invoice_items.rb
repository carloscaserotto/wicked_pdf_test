class RemoveInvoicesIdFromInvoiceItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :invoice_items, :invoices_ids, :integer
  end
end
