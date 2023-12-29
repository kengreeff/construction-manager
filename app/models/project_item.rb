class ProjectItem < ApplicationRecord
  belongs_to :category
  belongs_to :project
  belongs_to :project_space
  belongs_to :supplier, optional: true
  belongs_to :status, optional: true
  
  validates :title, presence: true

  before_create :set_default_attributes

  private

    def set_default_attributes
      self.attributes = {
        status: self.status || Status.find_by(key: "draft"),
      }
    end
end
