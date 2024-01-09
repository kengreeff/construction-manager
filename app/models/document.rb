class Document < ApplicationRecord
  has_one_attached :original_document

  belongs_to :project
  belongs_to :user

  validates :title, presence: true
end
