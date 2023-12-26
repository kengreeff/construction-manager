class Organization < ApplicationRecord
  has_many :clients

  has_many :organizations_projects
  has_many :projects, through: :organizations_projects
  
  has_many :organizations_users
  has_many :users, through: :organizations_users
end
