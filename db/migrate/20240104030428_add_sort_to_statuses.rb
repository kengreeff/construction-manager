class AddSortToStatuses < ActiveRecord::Migration[7.1]
  def change
    add_column :statuses, :sort, :integer, default: 0
  end
end
