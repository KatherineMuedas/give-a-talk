class Talk < ActiveRecord::Base
  # talk_type: string, title: string, description: text, status: string, 
  # justification: text, video: string, presentation: string, resources: hstore, 
  # user_id: integer, event_id: integer
  STATUSES = [['Pending', 'pending'], ['Accepted', 'accepted'], ['Rejected', 'rejected']]
  TALK_TYPES = [['Lightning', 'lightning'], ['Conference', 'conference'], ['Presentation', 'presentation']]

  belongs_to :user
  belongs_to :event
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :user, :talk_type, :status, :title, :description, presence: true
  validates_inclusion_of :talk_type, :in => TALK_TYPES.map(&:last), message: "Must be a valid talk type: #{Talk::TALK_TYPES.map(&:last).join(', ')}"
  validates_inclusion_of :status, :in => STATUSES.map(&:last), message: "Must have a valid status: #{Talk::STATUSES.map(&:last).join(', ')}"  

end
