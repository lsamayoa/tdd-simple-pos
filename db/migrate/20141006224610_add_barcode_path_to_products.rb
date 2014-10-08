class AddBarcodePathToProducts < ActiveRecord::Migration
  def change
    add_column :products, :barcode_path, :string
  end
end
