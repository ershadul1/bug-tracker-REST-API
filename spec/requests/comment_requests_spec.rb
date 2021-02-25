require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  before do
    @user = User.create(username: 'Batman', password: 'arkham')
    @project = Project.create(title: 'Project Title', description: 'Project description')
    @bug = Bug.create(title: 'Bug report Title', description: 'bug description', project_id: @project.id, author_id: @user.id)
  end

  describe 'GET show' do
    it 'get all comments of a bug report' do
      post '/api/v1/sessions', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      token = json_response['token']
      get "/api/v1/projects/#{@project.id}/bugs/#{@bug.id}/comments", headers: { Authorization: "Bearer #{token}" }
      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq('SUCCESS')
    end
  end

  describe 'POST create' do
    it 'create a comment' do
      post '/api/v1/sessions', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      user_id = json_response['user']['id']
      token = json_response['token']
      post "/api/v1/projects/#{@project.id}/bugs/#{@bug.id}/comments",
           headers: { Authorization: "Bearer #{token}" },
           params: { content: 'This is a comment'}
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Created comment')
    end

    it 'fails to create a comment' do
      post '/api/v1/sessions', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      user_id = json_response['user']['id']
      token = json_response['token']
      post "/api/v1/projects/#{@project.id}/bugs/#{@bug.id}/comments",
       headers: { Authorization: "Bearer #{token}" },
        params: { content: '' }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Comment not saved')
    end
  end

  describe 'PUT update' do
    it 'update a comment' do
      post '/api/v1/sessions', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      user_id = json_response['user']['id']
      token = json_response['token']
      post "/api/v1/projects/#{@project.id}/bugs/#{@bug.id}/comments",
      headers: { Authorization: "Bearer #{token}" },
      params: { content: 'This is a comment'}
      json_response = JSON.parse(response.body)
      comment_id = json_response['data']['id']
      put "/api/v1/projects/#{@project.id}/bugs/#{@bug.id}/comments",
       headers: { Authorization: "Bearer #{token}" },
        params: { content: 'This is an updated comment', id: comment_id}
      json_response = JSON.parse(response.body)
      expect(json_response['data']['content']).to eq('This is an updated comment')
    end

    it 'fails to update a comment' do
      post '/api/v1/sessions', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      user_id = json_response['user']['id']
      token = json_response['token']
      post "/api/v1/projects/#{@project.id}/bugs/#{@bug.id}/comments",
      headers: { Authorization: "Bearer #{token}" },
      params: { content: 'This is a comment'}
      json_response = JSON.parse(response.body)
      comment_id = json_response['data']['id']
      put "/api/v1/projects/#{@project.id}/bugs/#{@bug.id}/comments",
      headers: { Authorization: "Bearer #{token}" },
      params: { content: '', id: comment_id }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Comment not updated')
    end
  end

  describe 'DELETE destroy' do
    it 'destroy a comment' do
      post '/api/v1/sessions', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      user_id = json_response['user']['id']
      token = json_response['token']
      post "/api/v1/projects/#{@project.id}/bugs/#{@bug.id}/comments",
      headers: { Authorization: "Bearer #{token}" },
      params: { content: 'This is a comment'}
      json_response = JSON.parse(response.body)
      comment_id = json_response['data']['id']
      delete "/api/v1/projects/#{@project.id}/bugs/#{@bug.id}/comments",
             headers: { Authorization: "Bearer #{token}" },
             params: { content: 'This is an updated comment', id: comment_id }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Destroyed comment')
    end
  end
end
