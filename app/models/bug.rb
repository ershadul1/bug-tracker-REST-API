class Bug < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: 'User'
  has_many :comments, foreign_key: :bug_id, dependent: :destroy
  has_one :assign, foreign_key: :bug_id, dependent: :destroy
  has_one :resolve, foreign_key: :bug_id, dependent: :destroy
  validates :title, presence: true
  validates :description, presence: true

  scope :order_created, -> { order(created_at: :desc) }
  
  def details
    { bug: self, author_name: author.username, comments: comments,
      assign: assign, assignee_name: assign ? assign.user.username : nil,
      resolve: resolve }
  end
end
