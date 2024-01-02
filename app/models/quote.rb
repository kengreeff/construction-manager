class Quote < ApplicationRecord
  has_one_attached :original_document
  has_one_attached :signed_document

  belongs_to :project
  belongs_to :supplier
  belongs_to :user

  validates :reference, :total, presence: true
end
