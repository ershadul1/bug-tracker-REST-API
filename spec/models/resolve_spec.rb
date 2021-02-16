require 'rails_helper'

RSpec.describe Resolve, type: :model do
  context 'Validates bug_id' do
    it 'Should be valid' do
      user = User.create(username: 'rayhan', password: '1234')
      project = Project.create(title: 'Essential', description: 'Project description')
      bug = Bug.new(title: 'Bug1', description: 'Bug description1', author_id: user.id)
      project.bugs << bug
      assignment = Resolve.create(bug_id: bug.id, user_id: user.id)
      expect(assignment.save).to be true
    end

    it 'should not be valid' do
      user = User.create(username: 'rayhan', password: '1234')
      project = Project.create(title: 'Essential', description: 'Project description')
      bug = Bug.new(title: '', description: 'Bug description1', author_id: user.id)
      project.bugs << bug
      Resolve.create(bug_id: bug.id, user_id: user.id)
      assignment2 = Resolve.create(bug_id: bug.id, user_id: user.id)
      expect(assignment2.save).not_to be true
    end
  end

  context 'associations between bug and resolve model' do
    it 'a bug can be assigned' do
      user = User.create(username: 'rayhan', password: '1234')
      project = Project.create(title: 'Essential', description: 'Project description')
      bug1 = Bug.new(title: 'Bug 1', description: 'bug description 1', author_id: user.id)
      project.bugs << bug1
      resolvement = Resolve.create(bug_id: bug1.id, user_id: user.id)
      expect(bug1.resolve).to eql(resolvement)
    end
  end
end
