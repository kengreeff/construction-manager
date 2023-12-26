class Client < ApplicationRecord
  belongs_to :organization

  has_many :clients_projects
  has_many :projects, through: :clients_projects
end
