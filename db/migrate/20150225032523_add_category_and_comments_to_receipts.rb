class AddCategoryAndCommentsToReceipts < ActiveRecord::Migration
  def change
    add_column :receipts, :category, :string
    add_column :receipts, :comment, :string
  end
end
