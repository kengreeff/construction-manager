class ProjectSpace < ApplicationRecord
  belongs_to :project

  has_many :project_items
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
end

class ProjectSpaceCloner < Clowne::Cloner
  include_association :project_items

  trait :append_copy do
    finalize do |source, record, params|
      record.title = "#{source.title} Copy"
    end
  end
end
