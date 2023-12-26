class ProjectItem < ApplicationRecord
  belongs_to :project_space
  belongs_to :supplier, optional: true
  
  delegate :project, to: :project_space
end
