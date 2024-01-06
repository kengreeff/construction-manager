class ProjectItem < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  has_many :comments, as: :record

  belongs_to :category
  belongs_to :project
  belongs_to :project_space
  belongs_to :supplier, optional: true
  belongs_to :status, optional: true
  
  validates :title, presence: true

  before_create :set_default_attributes
  after_commit :add_changes_comment, on: :update

  private

    def set_default_attributes
      self.attributes = {
        status: self.status || Status.find_by(key: "draft"),
      }
    end

    def add_changes_comment
      if saved_changes?
        changes = saved_changes.except("updated_at", "created_at")

        changes_string = "#{Current.user.first_name} made the following changes:\n"
        changes_string = changes.keys.each_with_index.reduce(changes_string) do |acc, (key, index)|
          acc += "#{key}: #{changes[key][0]} => #{changes[key][1]}"
          acc += "\n" if index < changes.keys.length - 1
          acc
        end
        
        Comment.create(record: self, body: changes_string, user: Current.user)
      end
    end
end

class ProjectItemCloner < Clowne::Cloner
  finalize do |source, record, params|
    record.title = "#{source.title} Copy"
    record.image.attach(source.image.blob) if source.image.attached?
  end
end