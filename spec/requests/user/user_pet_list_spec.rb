require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Get My Pets request', type: :request do
  let(:user1) { Fabricate(:user) }
  let(:user2) { Fabricate(:user) }
  let(:admin_user) { Fabricate(:user, admin: true) }
  let(:url) { '/my-pets' }
  let(:headers) {{ 'Accept' => 'application/json', 'Content-Type' => 'application/json' }}
  let(:auth_header_user1) {Devise::JWT::TestHelpers.auth_headers(headers, user1)}
  let(:auth_header_user2) {Devise::JWT::TestHelpers.auth_headers(headers, user2)}
  let(:auth_header_admin) {Devise::JWT::TestHelpers.auth_headers(headers, admin_user)}

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

  context 'when admin user tries to access the service' do
    before do
      get url, headers: auth_header_admin
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

  context 'when user can only see his own pets' do
    before do
      Fabricate.times(4, :pet, user: user1)
      Fabricate.times(2, :pet, user: user2)
      get url, headers: auth_header_user2
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns valid json with the data' do
      json = JSON.parse(response.body)
      expect(json['success']).to eq(true)
      expect(json['petList']['totalCount']).to eq(2)
      expect(json['petList']['entries']).to be_present
    end
  end

end