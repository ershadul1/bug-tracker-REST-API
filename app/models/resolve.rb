class Resolve < ApplicationRecord
  validates_uniqueness_of :bug_id

  belongs_to :user
  belongs_to :bug

  after_save do
    bug = Bug.find_by(id: bug_id)
    bug.status = 'resolved'
    bug.save
  end

  after_destroy do
    bug = Bug.find_by(id: bug_id)
    bug.status = 'assigned'
    bug.save
  end
end
