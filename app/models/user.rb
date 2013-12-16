class User < ActiveRecord::Base
  # email: string,  first_name: string, last_name: string, user_name: string, 
  # organizations_count: integer, events_count: integer
  # encrypted_password: string, reset_password_token: string, reset_password_sent_at: datetime, remember_created_at: datetime, sign_in_count: integer, current_sign_in_at: datetime, last_sign_in_at: datetime, current_sign_in_ip: string, last_sign_in_ip: string, created_at: datetime, updated_at: datetime, confirmation_token: string, confirmed_at: datetime, confirmation_sent_at: datetime, unconfirmed_email: string, invitation_token: string, invitation_created_at: datetime, invitation_sent_at: datetime, invitation_accepted_at: datetime, invitation_limit: integer, invited_by_id: integer, invited_by_type: string,
  rolify
  
  extend FriendlyId
  friendly_id :full_name, use: :slugged

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :organizations
  has_many :talks
  has_many :comments
  
  # A user has a few types of events. Events he owns (all_events, events, organization_events) 
  # and events he attends (attending_events), join_table attendee_events
  has_many :events, as: :eventable
  has_many :organization_events, through: :organizations, source: :events
  has_many :attendee_events
  has_many :attending_events, through: :attendee_events, source: :event

  # Combines User Events & Organization Events
  def all_events
    events + organization_events
  end

  def full_name
    [first_name, last_name].join(' ')
  end

end
