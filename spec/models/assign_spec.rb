require 'rails_helper'

RSpec.describe Assign, type: :model do
  context 'Validates bug_id' do
    it 'Should be valid' do
      user = User.create(username: 'rayhan', password: '1234')
      project = Project.create(title: 'Essential', description: 'Project description')
      bug = Bug.new(title: 'Bug1', description: 'Bug description1', author_id: user.id)
      project.bugs << bug
      assignment = Assign.create(bug_id: bug.id, user_id: user.id)
      expect(assignment.save).to be true
    end

    it 'should not be valid' do
      user = User.create(username: 'rayhan', password: '1234')
      project = Project.create(title: 'Essential', description: 'Project description')
      bug = Bug.new(title: '', description: 'Bug description1', author_id: user.id)
      project.bugs << bug
      Assign.create(bug_id: bug.id, user_id: user.id)
      assignment2 = Assign.create(bug_id: bug.id, user_id: user.id)
      expect(assignment2.save).not_to be true
    end
  end

  context 'associations between bug and assign model' do
    it 'a bug can be assigned' do
      user = User.create(username: 'rayhan', password: '1234')
      project = Project.create(title: 'Essential', description: 'Project description')
      bug1 = Bug.new(title: 'Bug 1', description: 'bug description 1', author_id: user.id)
      project.bugs << bug1
      assignment = Assign.create(bug_id: bug1.id, user_id: user.id)
      expect(bug1.assign).to eql(assignment)
    end
  end

  context 'associations between user and assign model' do
    it 'a user can have many bug assigns' do
      user = User.create(username: 'rayhan', password: '1234')
      project = Project.create(title: 'Essential', description: 'Project description')
      bug1 = Bug.new(title: 'Bug 1', description: 'bug description 1', author_id: user.id)
      project.bugs << bug1
      Assign.create(bug_id: bug1.id, user_id: user.id)
      bug2 = Bug.new(title: 'Bug 2', description: 'bug description 2', author_id: user.id)
      project.bugs << bug2
      Assign.create(bug_id: bug2.id, user_id: user.id)
      expect(user.assigns.count).to eql(2)
    end
  end
end
