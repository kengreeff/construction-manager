class CreateOrganizationsProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :organizations_projects do |t|
      t.belongs_to :organization
      t.belongs_to :project

      t.timestamps
    end
  end
end
