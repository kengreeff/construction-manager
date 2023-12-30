class Comment < ApplicationRecord
  belongs_to :record, polymorphic: true
  belongs_to :user

  validates :body, presence: true
end
