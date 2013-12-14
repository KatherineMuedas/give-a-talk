class Tag < ActiveRecord::Base
  # name: string, taggable_id: integer, taggable_type: string
  belongs_to :taggable, polymorphic: true
  validates :taggable, :name, presence: true
end
