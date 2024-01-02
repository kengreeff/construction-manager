class Project < ApplicationRecord
  alias_attribute :items, :project_items
  alias_attribute :spaces, :project_spaces

  belongs_to :parent_project, class_name: 'Project', optional: true

  has_many :clients_projects
  has_many :clients, through: :clients_projects
  has_many :invoices
  has_many :organizations_projects
  has_many :organizations, through: :organizations_projects
  has_many :project_spaces, dependent: :destroy
  has_many :project_items, through: :project_spaces
  has_many :sub_projects, class_name: 'Project', foreign_key: 'parent_project_id'
  has_many :quotes

  def combined_clients_name
    if self.clients.size > 0
      return self.clients.first.title
    end

    return "No Client"
  end
end
