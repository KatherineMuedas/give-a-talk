class Talk < ActiveRecord::Base
  # talk_type: string, title: string, description: text, status: string, 
  # justification: text, video: string, presentation: string, resources: hstore, 
  # user_id: integer, event_id: integer

  STATUSES = [['Pending', 'pending'], ['Accepted', 'accepted'], ['Rejected', 'rejected']]
  TALK_TYPES = [['Lightning', 'lightning'], ['Conference', 'conference'], ['Presentation', 'presentation']]
  scope :accepted, -> { where(status: 'accepted') }
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  belongs_to :event
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  before_validation :set_talk_types_to_match_event_settings
  

  validates :user, :talk_type, :status, :title, :description, presence: true
  validates_inclusion_of :talk_type, :in => TALK_TYPES.map(&:last), message: "Must be a valid talk type: #{Talk::TALK_TYPES.map(&:last).join(', ')}"
  validates_inclusion_of :status, :in => STATUSES.map(&:last), message: "Must have a valid status: #{Talk::STATUSES.map(&:last).join(', ')}"  
  validate :talk_types_must_match_event_defaults
  validate :talk_submissions_obey_event, on: :create

  private

  def set_talk_types_to_match_event_settings
    if self.event 
      self.talk_type = self.event.talks_type if self.event.talks_type.present?
      self.duration = self.event.talks_duration if self.event.talks_duration.present?
    end
  end

  def talk_types_must_match_event_defaults
    if self.event && self.event.talks_type.present?
      errors.add(:talk_type, "must match event talk type") if self.talk_type != self.event.talks_type
    end

    if self.event && self.event.talks_duration.present?
      errors.add(:duration, "must match event duration")  if self.duration != self.event.talks_duration
    end
  end

  def talk_submissions_obey_event
    if self.event && self.event.talks_submissions_limit.present?
      errors.add(:base, "#{self.event.name} reached it's submission limit (#{self.event.talks_submissions_limit})") if self.event.talks.count.to_i >= self.event.talks_submissions_limit.to_i
    end
    if self.event && self.event.submissions_end_at.present?
      errors.add(:base, "#{self.event.name} stopped accepting talks at #{ActionController::Base.helpers.time_tag(self.event.submissions_end_at)}") if self.event.submissions_end_at < Time.now
    end    
  end
end
