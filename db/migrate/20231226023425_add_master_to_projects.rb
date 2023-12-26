class AddMasterToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :is_master, :boolean, default: false, null: false
    add_column :projects, :parent_project_id, :bigint
  end
end
