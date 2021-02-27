require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validates Username' do
    it 'Should be valid' do
      user = User.new(username: 'rayhan', password: '1234')
      expect(user.save).to be true
    end

    it 'should not be valid' do
      user = User.new(username: '', password: '1234')
      expect(user.save).not_to be true
    end
  end

  context 'Validates Password' do
    it 'Should be valid' do
      user = User.new(username: 'rayhan', password: '1234')
      expect(user.save).to be true
    end

    it 'should not be valid' do
      user = User.new(username: 'rayhan', password: '')
      expect(user.save).not_to be true
    end
  end
end
