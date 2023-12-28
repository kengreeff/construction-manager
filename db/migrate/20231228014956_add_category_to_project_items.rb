class AddCategoryToProjectItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :project_items, :category, null: true, foreign_key: true
  end
end
