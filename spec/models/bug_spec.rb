require 'rails_helper'

RSpec.describe Bug, type: :model do
  context 'Validates Bug title' do
    
    it 'Should be valid' do
      user = User.create(username: 'rayhan', password: '1234')
      project = Project.create(title: 'Essential', description: 'Project description')
      bug = Bug.new(title: 'Bug1', description: 'Bug description1', author_id: user.id)
      project.bugs << bug
      expect(bug.save).to be true
    end

    it 'should not be valid' do
      user = User.create(username: 'rayhan', password: '1234')
      project = Project.create(title: 'Essential', description: 'Project description')
      bug = Bug.new(title: '', description: 'Bug description1', author_id: user.id)
      project.bugs << bug
      expect(bug.save).not_to be true
    end
  end

  context 'Validates Bug description' do

    it 'Should be valid' do
      user = User.create(username: 'rayhan', password: '1234')
      project = Project.create(title: 'Essential', description: 'Project description')
      bug = Bug.new(title: 'Bug1', description: 'Bug description1', author_id: user.id)
      project.bugs << bug
      expect(bug.save).to be true
    end

    it 'should not be valid' do
      user = User.create(username: 'rayhan', password: '1234')
      project = Project.create(title: 'Essential', description: 'Project description')
      bug = Bug.new(title: 'Bug1', description: '', author_id: user.id)
      project.bugs << bug
      expect(bug.save).not_to be true
    end
  end

  context 'associations between bug and project model' do
    it 'a bug belongs to a project' do
      user = User.create(username: 'rayhan', password: '1234')
      project = Project.create(title: 'Essential', description: 'Project description')
      bug1 = Bug.new(title: 'Bug 1', description: 'bug description 1', author_id: user.id)
      project.bugs << bug1
      expect(bug1.project).to eql(project)
    end
  end
end