class CreateSuppliers < ActiveRecord::Migration[7.1]
  def change
    create_table :suppliers do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
