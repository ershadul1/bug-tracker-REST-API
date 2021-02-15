class Assign < ApplicationRecord
  validates_uniqueness_of :bug_id
  belongs_to :user
  belongs_to :bug
end
