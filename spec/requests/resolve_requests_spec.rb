require 'rails_helper'

RSpec.describe 'Resolves', type: :request do
  before do
    @user = User.create(username: 'Batman', password: 'arkham')
    @project = Project.create(title: 'Project Title', description: 'Project description')
    @bug = Bug.create(title: 'Bug report Title', description: 'bug description', project_id: @project.id, author_id: @user.id)
  end

  describe 'POST create' do
    it 'create a resolve' do
      post '/api/v1/sessions', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      token = json_response['token']
      post "/api/v1/projects/#{@project.id}/bugs/#{@bug.id}/resolves", headers: { Authorization: "Bearer #{token}" },
                                             params: { user_id: @user.id }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Resolved bug')
    end

    it 'fails to create a resolve' do
      post '/api/v1/sessions', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      token = json_response['token']
      post "/api/v1/projects/#{@project.id}/bugs/#{@bug.id}/resolves", headers: { Authorization: "Bearer #{token}" },
                                             params: { user_id: @user.id }
      post "/api/v1/projects/#{@project.id}/bugs/#{@bug.id}/resolves", headers: { Authorization: "Bearer #{token}" },
                                             params: { user_id: @user.id }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Bug not resolved')
    end
  end

  describe 'DELETE destroy' do
    it 'destroy a resolve' do
      post '/api/v1/sessions', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      user_id = json_response['user']['id']
      token = json_response['token']
      post "/api/v1/projects/#{@project.id}/bugs/#{@bug.id}/resolves", headers: { Authorization: "Bearer #{token}" },
                                             params: { user_id: @user.id }
      delete "/api/v1/projects/#{@project.id}/bugs/#{@bug.id}/resolves", headers: { Authorization: "Bearer #{token}" },
                                               params: { user_id: @user.id }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Destroyed bug resolve')
    end
  end
end
