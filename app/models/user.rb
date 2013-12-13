class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :organizations
  has_many :events, as: :eventable
  has_many :organization_events, through: :organizations, source: :events
  has_many :talks
  has_many :attendee_events
  has_many :attending_events, through: :attendee_events, source: :event
  has_many :comments
  
  # Combines User Events & Organization Events
  def all_events
    events + organization_events
  end
end
