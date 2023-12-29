class ProjectSpace < ApplicationRecord
  belongs_to :project

  has_many :project_items
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
end
