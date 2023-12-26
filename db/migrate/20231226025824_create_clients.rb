class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.belongs_to :organization
      t.string :title

      t.timestamps
    end
  end
end
