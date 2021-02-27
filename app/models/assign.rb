class Assign < ApplicationRecord
  validates_uniqueness_of :bug_id

  belongs_to :user
  belongs_to :bug

  after_save do
    bug = Bug.find_by(id: bug_id)
    bug.status = 'assigned'
    bug.save
  end

  after_destroy do
    bug = Bug.find_by(id: bug_id)
    bug.status = 'open'
    bug.save
  end

  def self.new_user_assign(user, assign_params)
    user_assigns = user.assigns
    user_assigns.new(assign_params)
  end
end
