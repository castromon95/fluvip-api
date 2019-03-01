require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Get All Profiles request', type: :request do
  let(:user) { Fabricate(:user, admin: true) }
  let(:no_admin_user) { Fabricate(:user) }
  let(:url) { '/all-profiles' }
  let(:headers) {{ 'Accept' => 'application/json', 'Content-Type' => 'application/json' }}
  let(:auth_headers) {Devise::JWT::TestHelpers.auth_headers(headers, user)}
  let(:no_admin_auth_headers) {Devise::JWT::TestHelpers.auth_headers(headers, no_admin_user)}

  context 'when jwt_token is invalid' do
    before do
      get url, headers: headers
    end

    it 'returns 401' do
      expect(response).to have_http_status(401)
    end

    it 'returns valid json with the data' do
      json = JSON.parse(response.body)
      expect(json['success']).to eq(false)
      expect(json['info']['message']).to eq('You need to sign in or sign up before continuing.')
      expect(json['info']['type']).to eq('error')
    end
  end

  context 'when a no admin user tries to access the service' do
    before do
      get url, headers: no_admin_auth_headers
    end

    it 'returns 401' do
      expect(response).to have_http_status(401)
    end

    it 'returns valid json with the data' do
      json = JSON.parse(response.body)
      expect(json['success']).to eq(false)
      expect(json['info']['message']).to eq('No estas autorizado para hacer esta accion!')
      expect(json['info']['type']).to eq('error')
    end
  end

  context 'when jwt token is valid' do
    before do
      Fabricate.times(4, :profile)
      get url, headers: auth_headers
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns valid json with the data' do
      json = JSON.parse(response.body)
      expect(json['success']).to eq(true)
      expect(json['profileList']['totalCount']).to eq(4)
      expect(json['profileList']['entries']).to be_present
    end
  end

  context 'when admin users are not listed' do
    before do
      Fabricate.times(3, :profile)
      Fabricate.times(2, :profile, user: Fabricate(:user, admin: true))
      get url, headers: auth_headers
    end

    it 'returns valid json with the data' do
      json = JSON.parse(response.body)
      expect(json['success']).to eq(true)
      expect(json['profileList']['totalCount']).to eq(3)
      expect(json['profileList']['entries']).to be_present
    end
  end
end