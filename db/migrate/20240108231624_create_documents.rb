class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.belongs_to :project, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
