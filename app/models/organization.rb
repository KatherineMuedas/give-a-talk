class Organization < ActiveRecord::Base
  # Organization(id: integer, user_id: integer, name: string, website: string, 
  # about: text, created_at: datetime, updated_at: datetime)
  belongs_to :user, counter_cache: true
  has_many :events, as: :eventable
  has_many :talks, through: :events
  has_many :attendees, through: :events, source: :attendees
  has_many :tags, as: :taggable, dependent: :destroy
end
