class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.string :business_name
      t.decimal :sub_total, precision: 8, scale: 2
      t.decimal :tax_total, precision: 8, scale: 2
      t.decimal :total, precision: 8, scale: 2
      t.string :tax_type
      t.references :report, index: true

      t.timestamps null: false
    end
    add_foreign_key :receipts, :reports
  end
end
