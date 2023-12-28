class AddAdditionalAttributesToProjectItems < ActiveRecord::Migration[7.1]
  def change
    add_column :project_items, :internal_code, :string
    add_column :project_items, :unit_price, :decimal, :precision => 8, :scale => 2
    add_column :project_items, :finish, :string
    add_column :project_items, :material, :string
    add_column :project_items, :colour, :string
  end
end
