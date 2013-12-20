class AttendeeEvent < ActiveRecord::Base
  # user_id: integer, event_id: integer
  belongs_to :user
  belongs_to :event

  validates :user, :event, presence: true

  validate :users_can_only_rsvp_once

  private

  def users_can_only_rsvp_once
    errors.add(:base, "You are already attending #{self.event.name}") unless AttendeeEvent.where(user_id: self.user_id, event_id: self.event_id).empty?
  end
end
