class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.decimal :total
      t.belongs_to :client, index: true
      t.belongs_to :seller, index: true

      t.timestamps
    end
  end
end
