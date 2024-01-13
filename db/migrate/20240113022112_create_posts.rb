class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.belongs_to :project
      t.belongs_to :user

      t.string :title

      t.timestamps
    end
  end
end
