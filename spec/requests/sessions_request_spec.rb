require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'POST create' do
    it 'login User' do
      User.create(username: 'Batman', password: 'arkham')
      post '/api/v1/sessions', params: { username: 'Batman', password: 'arkham' }
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(%w[status user token])
    end

    it 'fails to login User' do
      User.create(username: 'Batman', password: 'arkham')
      post '/api/v1/sessions', params: { username: 'Batman', password: 'arkha' }
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(['error', 'status'])
    end
  end
end
