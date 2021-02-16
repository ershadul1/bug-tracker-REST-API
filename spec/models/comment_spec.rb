require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'Validates Comment content' do
    it 'Should be valid' do
      user = User.create(username: 'rayhan', password: '1234')
      project = Project.create(title: 'Essential', description: 'Project description')
      bug = Bug.new(title: 'Bug1', description: 'Bug description1', author_id: user.id)
      project.bugs << bug
      comment = Comment.new(content: 'This is a comment', bug_id: bug.id, user_id: user.id)
      expect(comment.save).to be true
    end

    it 'should not be valid' do
      user = User.create(username: 'rayhan', password: '1234')
      project = Project.create(title: 'Essential', description: 'Project description')
      bug = Bug.new(title: 'Bug1', description: 'Bug description1', author_id: user.id)
      project.bugs << bug
      comment = Comment.new(content: '', bug_id: bug.id, user_id: user.id)
      expect(comment.save).not_to be true
    end
  end

  context 'associations between comment and bug model' do
    it 'a comment belongs to a bug' do
      user = User.create(username: 'rayhan', password: '1234')
      project = Project.create(title: 'Essential', description: 'Project description')
      bug1 = Bug.new(title: 'Bug 1', description: 'bug description 1', author_id: user.id)
      project.bugs << bug1
      comment = Comment.new(content: 'This is a comment', bug_id: bug1.id, user_id: user.id)
      bug1.comments << comment
      expect(bug1.comments.first).to eql(comment)
    end

    it 'a bug can have many comments' do
      user = User.create(username: 'rayhan', password: '1234')
      project = Project.create(title: 'Essential', description: 'Project description')
      bug1 = Bug.new(title: 'Bug 1', description: 'bug description 1', author_id: user.id)
      project.bugs << bug1
      comment1 = Comment.new(content: 'This is a comment 1', bug_id: bug1.id, user_id: user.id)
      bug1.comments << comment1
      comment2 = Comment.new(content: 'This is a comment 2', bug_id: bug1.id, user_id: user.id)
      bug1.comments << comment2
      expect(bug1.comments.count).to eql(2)
    end
  end
end
