class Comment < ActiveRecord::Base
  # text: text, reply_to_id: integer, user_id: integer, 
  # commentable_id: integer, commentable_type: string
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :reply_to, :class_name => "Comment"

  has_many :replies, :class_name  => "Comment", :foreign_key => "reply_to_id", :dependent   => :nullify 

  validates :user, :commentable, :text, presence: true
end
