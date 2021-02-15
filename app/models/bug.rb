class Bug < ApplicationRecord
  belongs_to :project
  has_many :comments, foreign_key: :bug_id, dependent: :destroy
end
