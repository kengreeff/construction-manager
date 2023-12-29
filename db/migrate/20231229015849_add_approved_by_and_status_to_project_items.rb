class AddApprovedByAndStatusToProjectItems < ActiveRecord::Migration[7.1]
  def change
    add_column :project_items, :approved_by_user_id, :bigint
    add_column :project_items, :approved_at, :datetime
    add_reference :project_items, :status, null: true, foreign_key: true
  end
end
