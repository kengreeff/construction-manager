class CreateProjectSpaces < ActiveRecord::Migration[7.1]
  def change
    create_table :project_spaces do |t|
      t.belongs_to :project
      t.string :title, null: false

      t.timestamps
    end
  end
end
