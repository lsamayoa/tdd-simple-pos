class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.decimal :salary
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
