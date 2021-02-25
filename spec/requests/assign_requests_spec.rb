require 'rails_helper'

RSpec.describe 'Assigns', type: :request do
  describe 'POST create' do
    it 'create an assign' do
      user = User.create(username: 'Batman', password: 'arkham')
      project = Project.create(title: 'Project Title', description: 'Project description')
      bug = Bug.create(title: 'Bug report Title', description: 'bug description', project_id: project.id, author_id: user.id)
      post '/api/v1/sessions', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      user_id = json_response['user']['id']
      token = json_response['token']
      post "/api/v1/projects/#{project.id}/bugs/#{bug.id}/assigns", headers: { Authorization: "Bearer #{token}" }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Assigned bug')
    end

    it 'fails to create an assign' do
      user = User.create(username: 'Batman', password: 'arkham')
      project = Project.create(title: 'Project Title', description: 'Project description')
      bug = Bug.create(title: 'Bug report Title', description: 'bug description', project_id: project.id, author_id: user.id)
      post '/api/v1/sessions', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      user_id = json_response['user']['id']
      token = json_response['token']
      post "/api/v1/projects/#{project.id}/bugs/#{bug.id}/assigns", headers: { Authorization: "Bearer #{token}" },
                                            params: { bug_id: Bug.first.id, user_id: user_id }
      post "/api/v1/projects/#{project.id}/bugs/#{bug.id}/assigns", headers: { Authorization: "Bearer #{token}" },
                                            params: { bug_id: Bug.first.id, user_id: user_id }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Bug not assigned')
    end
  end

  describe 'DELETE destroy' do
    it 'destroy an assign' do
      user = User.create(username: 'Batman', password: 'arkham')
      project = Project.create(title: 'Project Title', description: 'Project description')
      bug = Bug.create(title: 'Bug report Title', description: 'bug description', project_id: project.id, author_id: user.id)
      post '/api/v1/sessions', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      user_id = json_response['user']['id']
      token = json_response['token']
      post "/api/v1/projects/#{project.id}/bugs/#{bug.id}/assigns", headers: { Authorization: "Bearer #{token}" },
                                            params: { bug_id: Bug.first.id, user_id: user_id }
      delete "/api/v1/projects/#{project.id}/bugs/#{bug.id}/assigns", headers: { Authorization: "Bearer #{token}" },
                                              params: { bug_id: Bug.first.id, user_id: user_id }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Destroyed bug assign')
    end
  end
end
