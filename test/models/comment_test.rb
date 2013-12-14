require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  before do
    @user = create(:user)
    @event = create(:event, eventable: @user)
    @comment = build(:comment, user: @user, commentable: @event)
  end

  it 'must belong to a user' do
    @comment.user = nil
    assert @comment.invalid?
    @comment.save
    assert @comment.errors[:user].present?
  end

  it 'must belong to a commentable object' do
    @comment.commentable = nil
    assert @comment.invalid?
    @comment.save
    assert @comment.errors[:commentable].present?
  end

  it 'must have text to be a valid comment' do
    @comment.text = nil
    assert @comment.invalid?    
    @comment.save
    assert @comment.errors[:text].present?
  end

  # This test is not necessary, as it's just kind of testing the way AR works anyways, but it's here for sanity
  it "clears the reply_to_id for all replies" do
    created_comment = create(:comment, user: @user, commentable: @event)
    reply = create(:comment, user: @user, commentable: @event, reply_to: created_comment )

    reply.reply_to.must_equal created_comment
    created_comment.destroy
    reply.reload
    reply.reply_to.must_equal nil
  end
end
