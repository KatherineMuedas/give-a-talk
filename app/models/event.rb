class Event < ActiveRecord::Base
  # name: string, description: text, begins_at: datetime, ends_at: datetime, 
  # website: string, eventable_id: integer, eventable_type: string
  # talks_type: string, talks_duration: integer, talks_slots: integer, 
  # talks_submissions_limit: integer, submissions_end_at: datetime

  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :eventable, polymorphic: true, counter_cache: true
  has_many :talks
  has_many :attendee_event, dependent: :destroy
  has_many :attendees, through: :attendee_event, source: :user
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_one :location, as: :locateable, dependent: :destroy

  validates :name, :eventable, :description, presence: true
  validate :start_must_be_before_end_time
  validates_inclusion_of :talks_type, in: Talk::TALK_TYPES.map(&:last), message: "Must be a valid talk type: #{Talk::TALK_TYPES.map(&:last).join(', ')}", allow_blank: true

  def accepts_talk_submissions?
    if self.submissions_end_at.present? && Time.now > self.submissions_end_at
      false
    elsif self.talks_submissions_limit.present? && self.talks.count > self.talks_submissions_limit
      false
    else
      true
    end
  end

  def talks_submitted
    "#{self.talks.count.to_s}#{'/'.to_s + self.talks_submissions_limit.to_s if self.talks_submissions_limit.present? }"
  end

  def filled_talks
    "#{self.talks.accepted.count.to_s}#{'/'.to_s + self.talks_slots.to_s if self.talks_slots.present?}"
  end

  def attend(user)
    self.attendees << user
  end

  def unattend(user)
    self.attendees.delete user
  end
  
  private
  def start_must_be_before_end_time
    errors.add(:begins_at, "must be present if ends at time is set") if ends_at.present? && !begins_at.present?
    if ends_at.present? && begins_at
      errors.add(:ends_at, "must be after begins at time") unless ends_at >= begins_at
    end
  end 

end
