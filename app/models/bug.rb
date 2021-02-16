class Bug < ApplicationRecord
  belongs_to :project
  has_many :comments, foreign_key: :bug_id, dependent: :destroy
  has_one :assign, foreign_key: :bug_id, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
end
