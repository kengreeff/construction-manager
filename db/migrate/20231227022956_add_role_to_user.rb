class AddRoleToUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :role, null: true, foreign_key: true
  end
end
