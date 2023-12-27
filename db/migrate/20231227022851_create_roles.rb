class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles do |t|
      t.string :title
      t.string :key

      t.timestamps
    end
  end
end
