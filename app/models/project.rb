class Project < ApplicationRecord
  alias_attribute :items, :project_items
  alias_attribute :spaces, :project_spaces

  belongs_to :parent_project, class_name: 'Project', optional: true

  has_many :organizations_projects
  has_many :organizations, through: :organizations_projects
  
  has_many :sub_projects, class_name: 'Project', foreign_key: 'parent_project_id'

  has_many :project_spaces, dependent: :destroy
  has_many :project_items, through: :project_spaces
end
