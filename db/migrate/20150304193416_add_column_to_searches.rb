class AddColumnToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :title, :string
    add_column :searches, :category, :string
    add_column :searches, :not_name, :string
    add_column :searches, :between, :string
  end
end
