class AddProjectToProjectItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :project_items, :project, null: true, foreign_key: true
  end
end
