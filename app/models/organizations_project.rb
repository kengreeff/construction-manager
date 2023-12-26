class OrganizationsProject < ApplicationRecord
  belongs_to :organization
  belongs_to :project
end
