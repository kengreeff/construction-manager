class ProjectItem < ApplicationRecord
  belongs_to :category
  belongs_to :project
  belongs_to :project_space
  belongs_to :supplier, optional: true
  
  validates :title, presence: true
end
