class Organization < ActiveRecord::Base
  # user_id: integer, name: string, website: string, about: text
  belongs_to :user, counter_cache: true
  has_many :events, as: :eventable
  has_many :talks, through: :events
  has_many :attendees, through: :events, source: :attendees
  has_many :tags, as: :taggable, dependent: :destroy

  validates :user, :name, :about, presence: true
end
