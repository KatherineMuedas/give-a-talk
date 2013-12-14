class AttendeeEvent < ActiveRecord::Base
  # user_id: integer, event_id: integer
  belongs_to :user
  belongs_to :event

  validates :user, :event, presence: true
end
