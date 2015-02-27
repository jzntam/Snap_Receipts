class AddGeocodingFieldsToReceipts < ActiveRecord::Migration
  def change
    add_column :receipts, :address, :string
    add_column :receipts, :longitude, :float
    add_column :receipts, :latitude, :float
  end
end
