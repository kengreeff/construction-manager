class Post < ApplicationRecord
  has_rich_text :content

  belongs_to :project
  belongs_to :user

  has_many :comments, as: :record, dependent: :destroy

  validates :title, presence: true
end
