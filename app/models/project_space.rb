class ProjectSpace < ApplicationRecord
  belongs_to :project
  has_many :project_items
end
