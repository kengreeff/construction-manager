class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.belongs_to :record, polymorphic: true
      t.belongs_to :user, foreign_key: true
      t.text :body
      t.jsonb :data

      t.timestamps
    end
  end
end
