class Event < ActiveRecord::Base
  # name: string, description: text, begins_at: datetime, ends_at: datetime, 
  # website: string, eventable_id: integer, eventable_type: string

  belongs_to :eventable, polymorphic: true, counter_cache: true
  has_many :talks
  has_many :attendee_event
  has_many :attendees, through: :attendee_event, source: :user
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :name, :eventable, :description, presence: true
  validate :start_must_be_before_end_time


  private
  def start_must_be_before_end_time
    errors.add(:begins_at, "must be present if ends at time is set") if ends_at.present? && !begins_at.present?
    if ends_at.present? && begins_at
      errors.add(:ends_at, "must be after begins at time") unless ends_at >= begins_at
    end
  end 

end
