require 'rails_helper'

RSpec.describe 'Users', type: :request do
  
  describe 'POST create' do
    it 'create new User' do
      post "/api/v1/users", params: { username: "Batman", password: "arkham" }
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(["user", "token"])
    end

    it 'fails to create new User' do
      post "/api/v1/users", params: { username: "Batman", password: "" }
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(["error"])
    end
  end

  describe 'POST login' do
    it 'login User' do
      User.create(username: 'Batman', password: 'arkham')
      post "/api/v1/login", params: { username: "Batman", password: "arkham" }
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(["user", "token"])
    end

    it 'fails to login User' do
      User.create(username: 'Batman', password: 'arkham')
      post "/api/v1/login", params: { username: "Batman", password: "arkha" }
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(["error"])
    end
  end

  describe 'Get auto_login' do
    it 'auto_login User' do
      post "/api/v1/users", params: { username: "Batman", password: "arkham" }
      json_response = JSON.parse(response.body)
      token = json_response["token"]
      get "/api/v1/auto_login",headers: { Authorization: "Bearer #{token}" },
       params: { username: "Batman", password: "arkham" }
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(["created_at", "id", "password_digest", "updated_at", "username"])
    end

    it 'fails to auto_login User' do
      post "/api/v1/users", params: { username: "Batman", password: "arkham" }
      get "/api/v1/auto_login", params: { username: "Batman", password: "arkham" }
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(["message"])
    end
  end

  describe 'PUT update' do
    it 'update User' do
      post "/api/v1/users", params: { username: "Batman", password: "arkham" }
      json_response = JSON.parse(response.body)
      id = json_response["user"]["id"]
      token = json_response["token"]
      put "/api/v1/users", headers: { Authorization: "Bearer #{token}" },
      params: { username: "Batman", password: "arkham", id: id }
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(["user", "token"])
    end

    it 'fails to update User' do
      post "/api/v1/users", params: { username: "Batman", password: "arkham" }
      json_response = JSON.parse(response.body)
      id = json_response["user"]["id"]
      put "/api/v1/users", params: { username: "Batman", password: "arkham", id: id }
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to match_array(["message"])
    end
  end
end