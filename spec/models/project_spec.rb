require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'Validates Project title' do
    it 'Should be valid' do
      project = Project.new(title: 'Essential', description: 'Project description')
      expect(project.save).to be true
    end

    it 'should not be valid' do
      project = Project.new(title: '', description: 'Project description')
      expect(project.save).not_to be true
    end
  end

  context 'Validates Project description' do
    it 'Should be valid' do
      project = Project.new(title: 'Essential', description: 'Project description')
      expect(project.save).to be true
    end

    it 'should not be valid' do
      project = Project.new(title: 'Essential', description: '')
      expect(project.save).not_to be true
    end
  end

  context 'associations between project and bug model' do
    it 'a project can have many bugs' do
      user = User.create(username: 'rayhan', password: '1234')
      project = Project.create(title: 'Essential', description: 'Project description')
      bug1 = Bug.new(title: 'Bug 1', description: 'bug description 1', author_id: user.id)
      bug2 = Bug.new(title: 'Bug 2', description: 'bug description 2', author_id: user.id)
      project.bugs << bug1
      project.bugs << bug2
      expect(project.bugs.count).to eql(2)
    end
  end
end