class CreateProjectItems < ActiveRecord::Migration[7.1]
  def change
    create_table :project_items do |t|
      t.belongs_to :project_space
      t.string :title, null: false
      
      t.integer :quantity, default: 1
      t.belongs_to :supplier
      t.text :description
      t.string :product_code
      t.string :url

      t.timestamps
    end
  end
end
