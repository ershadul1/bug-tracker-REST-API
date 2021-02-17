require 'rails_helper'

RSpec.describe 'Assigns', type: :request do
  before do
    user = User.create(username: 'Batman', password: 'arkham')
    project = Project.create(title: 'Project Title', description: 'Project description')
    Bug.create(title: 'Bug report Title', description: 'bug description', project_id: project.id, author_id: user.id)
  end

  describe 'POST create' do
    it 'create an assign' do
      post '/api/v1/login', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      user_id = json_response['user']['id']
      token = json_response['token']
      post '/api/v1/projects/bugs/assigns', headers: { Authorization: "Bearer #{token}" },
                                            params: { bug_id: Bug.first.id, user_id: user_id }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Assigned bug')
    end

    it 'fails to create an assign' do
      post '/api/v1/login', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      user_id = json_response['user']['id']
      token = json_response['token']
      post '/api/v1/projects/bugs/assigns', headers: { Authorization: "Bearer #{token}" },
                                            params: { bug_id: Bug.first.id, user_id: user_id }
      post '/api/v1/projects/bugs/assigns', headers: { Authorization: "Bearer #{token}" },
                                            params: { bug_id: Bug.first.id, user_id: user_id }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Bug not assigned')
    end
  end

  describe 'DELETE destroy' do
    it 'destroy an assign' do
      post '/api/v1/login', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      user_id = json_response['user']['id']
      token = json_response['token']
      post '/api/v1/projects/bugs/assigns', headers: { Authorization: "Bearer #{token}" },
                                            params: { bug_id: Bug.first.id, user_id: user_id }
      delete '/api/v1/projects/bugs/assigns', headers: { Authorization: "Bearer #{token}" },
                                              params: { bug_id: Bug.first.id, user_id: user_id }
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Destroyed bug assign')
    end
  end
end
