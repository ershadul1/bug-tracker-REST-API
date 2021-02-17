require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  describe 'GET show' do
    it 'get all projects' do
      post '/api/v1/users', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      token = json_response['token']
      get '/api/v1/projects', headers: { Authorization: "Bearer #{token}" }
      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq('SUCCESS')
    end

    it 'fails to get all projects' do
      get '/api/v1/projects'
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(['message'])
    end
  end

  describe 'POST create' do
    it 'create a project' do
      post '/api/v1/users', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      token = json_response['token']
      post '/api/v1/projects',
           headers: { Authorization: "Bearer #{token}" },
           params: { title: 'Project Title', description: 'Project description' }
      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq('SUCCESS')
    end

    it 'fails to create a project' do
      post '/api/v1/users', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      token = json_response['token']
      post '/api/v1/projects',
           headers: { Authorization: "Bearer #{token}" },
           params: { title: 'Project Title', description: '' }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Project not created')
    end
  end

  describe 'PUT update' do
    it 'update a project' do
      post '/api/v1/users', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      token = json_response['token']
      post '/api/v1/projects',
           headers: { Authorization: "Bearer #{token}" },
           params: { title: 'Project Title', description: 'Project description' }
      json_response = JSON.parse(response.body)
      id = json_response['data']['id']
      put '/api/v1/projects',
          headers: { Authorization: "Bearer #{token}" },
          params: { title: 'Project Title Changed', description: 'Project description changed', id: id }
      json_response = JSON.parse(response.body)
      expect(json_response['data']['title']).to eq('Project Title Changed')
    end

    it 'fails to update a project' do
      post '/api/v1/users', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      token = json_response['token']
      post '/api/v1/projects',
           headers: { Authorization: "Bearer #{token}" },
           params: { title: 'Project Title', description: 'Project description' }
      json_response = JSON.parse(response.body)
      id = json_response['data']['id']
      put '/api/v1/projects',
          headers: { Authorization: "Bearer #{token}" },
          params: { title: 'Project Title Changed', description: '', id: id }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Project not updated')
    end
  end

  describe 'DELETE destroy' do
    it 'destroy a project' do
      post '/api/v1/users', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      token = json_response['token']
      post '/api/v1/projects',
           headers: { Authorization: "Bearer #{token}" },
           params: { title: 'Project Title', description: 'Project description' }
      json_response = JSON.parse(response.body)
      id = json_response['data']['id']
      delete '/api/v1/projects', headers: { Authorization: "Bearer #{token}" },
                                 params: { id: id }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Destroyed project')
    end
  end
end
