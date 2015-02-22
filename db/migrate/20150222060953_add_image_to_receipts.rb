class AddImageToReceipts < ActiveRecord::Migration
  def change
    add_column :receipts, :image, :string
  end
end
