class Event < ActiveRecord::Base
  belongs_to :eventable, polymorphic: true, counter_cache: true
  has_many :talks
  has_many :attendee_event
  has_many :attendees, through: :attendee_event, source: :user
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
end
