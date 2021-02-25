require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST create' do
    it 'create new User' do
      post '/api/v1/users', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(%w[status user token])
    end

    it 'fails to create new User' do
      post '/api/v1/users', params: { username: 'Batman', password: '' }
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(['error', 'status'])
    end
  end



  describe 'GET user' do
    it 'get User data' do
      post '/api/v1/users', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      token = json_response['token']
      get '/api/v1/users', headers: { Authorization: "Bearer #{token}" }
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(%w[status user])
    end

    it 'fails to get User data' do
      post '/api/v1/users', params: { username: 'Batman', password: 'arkham' }
      get '/api/v1/users', headers: { Authorization: "Bearer 1234" }
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(['message'])
    end
  end

  describe 'PUT update' do
    it 'update User' do
      post '/api/v1/users', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      id = json_response['user']['id']
      token = json_response['token']
      put "/api/v1/users", headers: { Authorization: "Bearer #{token}" },
                           params: { username: 'Superman', password: 'arkham', id: id }
      json_response = JSON.parse(response.body)
      expect(json_response['user']['username']).to eq('Superman')
    end

    it 'fails to update User' do
      post '/api/v1/users', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      id = json_response['user']['id']
      token = json_response['token']
      put '/api/v1/users',
          headers: { Authorization: "Bearer #{token}" },
          params: { username: 'Batman', password: '', id: id }
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Unable to change username and password')
    end
  end
end
