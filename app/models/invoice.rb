class Invoice < ApplicationRecord
  has_one_attached :original_document
  has_one_attached :remittance_document

  belongs_to :project
  belongs_to :quote, optional: true
  belongs_to :supplier
  belongs_to :user

  validates :due_date, :reference, :total, presence: true
end
