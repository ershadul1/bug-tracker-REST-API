require 'rails_helper'

RSpec.describe 'Bugs', type: :request do
  before { Project.create(title: 'Project Title', description: 'Project description') }

  describe 'GET show' do
    it 'get all bugs' do
      post '/api/v1/users', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      token = json_response['token']
      get '/api/v1/projects/bugs', headers: { Authorization: "Bearer #{token}" }
      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq('SUCCESS')
    end
  end

  describe 'POST create' do
    it 'create a bug report' do
      post '/api/v1/users', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      user_id = json_response['user']['id']
      token = json_response['token']
      project_id = Project.first.id
      post '/api/v1/projects/bugs',
           headers: { Authorization: "Bearer #{token}" },
           params: { title: 'Bug report Title', description: 'bug description',
                     project_id: project_id, author_id: user_id }
      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq('SUCCESS')
    end

    it 'fails to create a bug report' do
      post '/api/v1/users', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      token = json_response['token']
      post '/api/v1/projects/bugs',
           headers: { Authorization: "Bearer #{token}" },
           params: { title: 'Bug report Title', description: '' }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Bug report not saved')
    end
  end

  describe 'PUT update' do
    it 'update a bug report' do
      post '/api/v1/users', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      user_id = json_response['user']['id']
      token = json_response['token']
      project_id = Project.first.id
      bug = Bug.create(title: 'Bug report Title', description: 'bug description',
                       project_id: project_id, author_id: user_id)
      put '/api/v1/projects/bugs',
          headers: { Authorization: "Bearer #{token}" },
          params: { title: 'Bug report Title Changed', description: 'Bug report description changed', id: bug.id }
      json_response = JSON.parse(response.body)
      expect(json_response['data']['title']).to eq('Bug report Title Changed')
    end

    it 'fails to update a bug report' do
      post '/api/v1/users', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      user_id = json_response['user']['id']
      token = json_response['token']
      project_id = Project.first.id
      bug = Bug.create(title: 'Bug report Title', description: 'bug description',
                       project_id: project_id, author_id: user_id)
      put '/api/v1/projects/bugs',
          headers: { Authorization: "Bearer #{token}" },
          params: { title: 'Bug report Title Changed', description: '', id: bug.id }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Bug report not updated')
    end
  end

  describe 'DELETE destroy' do
    it 'destroy a bug report' do
      post '/api/v1/users', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      token = json_response['token']
      user_id = json_response['user']['id']
      project_id = Project.first.id
      bug = Bug.create(title: 'Bug report Title', description: 'bug description',
                       project_id: project_id, author_id: user_id)
      delete '/api/v1/projects/bugs',
             headers: { Authorization: "Bearer #{token}" },
             params: { id: bug.id }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Destroyed bug report')
    end
  end
end
