class CreateSaleDetails < ActiveRecord::Migration
  def change
    create_table :sale_details do |t|
      t.belongs_to :sale, index: true
      t.integer :quantity
      t.belongs_to :product, index: true
      t.decimal :subtotal

      t.timestamps
    end
  end
end
