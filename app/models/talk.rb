class Talk < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  
  validates :user, :event, presence: true

end
