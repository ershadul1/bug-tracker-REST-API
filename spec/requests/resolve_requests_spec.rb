require 'rails_helper'

RSpec.describe 'Resolves', type: :request do
  before do
    user = User.create(username: 'Batman', password: 'arkham')
    project = Project.create(title: 'Project Title', description: 'Project description')
    Bug.create(title: 'Bug report Title', description: 'bug description', project_id: project.id, author_id: user.id)
  end

  describe 'POST create' do
    it 'create a resolve' do
      post '/api/v1/login', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      user_id = json_response['user']['id']
      token = json_response['token']
      post '/api/v1/projects/bugs/resolves', headers: { Authorization: "Bearer #{token}" },
                                             params: { bug_id: Bug.first.id, user_id: user_id }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Resolved bug')
    end

    it 'fails to create a resolve' do
      post '/api/v1/login', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      user_id = json_response['user']['id']
      token = json_response['token']
      post '/api/v1/projects/bugs/resolves', headers: { Authorization: "Bearer #{token}" },
                                             params: { bug_id: Bug.first.id, user_id: user_id }
      post '/api/v1/projects/bugs/resolves', headers: { Authorization: "Bearer #{token}" },
                                             params: { bug_id: Bug.first.id, user_id: user_id }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Bug not resolved')
    end
  end

  describe 'DELETE destroy' do
    it 'destroy a resolve' do
      post '/api/v1/login', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      user_id = json_response['user']['id']
      token = json_response['token']
      post '/api/v1/projects/bugs/resolves', headers: { Authorization: "Bearer #{token}" },
                                             params: { bug_id: Bug.first.id, user_id: user_id }
      delete '/api/v1/projects/bugs/resolves', headers: { Authorization: "Bearer #{token}" },
                                               params: { bug_id: Bug.first.id, user_id: user_id }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Destroyed bug resolve')
    end
  end
end
