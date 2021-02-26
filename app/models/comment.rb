class Comment < ApplicationRecord
  belongs_to :bug
  belongs_to :user
  validates :content, presence: true

  def self.bug_comments(bug_id)
    Comment.where(bug_id: bug_id).order(created_at: :desc)
  end

  def self.new_user_comment(user, comment_params)
    user_comments = user.comments
    user_comments.new(comment_params)
  end
end
