class Project < ApplicationRecord
  alias_attribute :items, :project_items
  alias_attribute :spaces, :project_spaces

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [500, 340]
  end

  belongs_to :parent_project, class_name: 'Project', optional: true

  has_many :clients_projects
  has_many :clients, through: :clients_projects
  has_many :documents
  has_many :invoices
  has_many :organizations_projects
  has_many :organizations, through: :organizations_projects
  has_many :project_spaces, dependent: :destroy
  has_many :project_items, through: :project_spaces
  has_many :sub_projects, class_name: 'Project', foreign_key: 'parent_project_id'
  has_many :quotes

  scope :joins_parent_project, -> {
    joins('LEFT JOIN projects parent_projects ON projects.parent_project_id = parent_projects.id')
  }

  scope :joins_sub_projects, -> {
    joins('INNER JOIN projects sub_projects ON projects.id = sub_projects.parent_project_id')
  }

  def combined_clients_name
    if self.clients.size > 0
      return self.clients.map { |c| c.title }.join(" / ")
    end

    return "No Client"
  end

  def master_project
    return self.parent_project if !self.is_master
    return self
  end
end
