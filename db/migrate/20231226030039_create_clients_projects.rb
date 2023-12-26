class CreateClientsProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :clients_projects do |t|
      t.belongs_to :client
      t.belongs_to :project

      t.timestamps
    end
  end
end
