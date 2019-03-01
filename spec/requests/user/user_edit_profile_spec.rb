require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Edit Profile request', type: :request do
  let(:profile) { Fabricate(:profile) }
  let(:admin_profile) { Fabricate(:profile, user: Fabricate(:user, admin: true)) }
  let(:url) { '/profiles' }
  let(:headers) {{ 'Accept' => 'application/json' }}
  let(:auth_header_user1) {Devise::JWT::TestHelpers.auth_headers(headers, profile.user)}
  let(:auth_header_admin) {Devise::JWT::TestHelpers.auth_headers(headers, admin_profile.user)}
  let(:params) do
    {
        "profile": {
            "name": "Nicolas",
            "last_name": "Gabriel",
            "phone": "34234232413"
        }
    }
  end
  let(:bad_params) do
    {
        "profile": {
            "name": "ds",
            "last_name": "Fluvip",
            "phone": "3124336574"
        }
    }
  end

  context 'when jwt_token is invalid' do
    before do
      post url, headers: headers
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
      post url, headers: auth_header_admin
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

  context 'when fields are fine' do
    before do
      post url, params: params, headers: auth_header_user1
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns valid json with the data' do
      json = JSON.parse(response.body)
      expect(json['success']).to eq(true)
      expect(json['info']['message']).to eq('Perfil editado exitosamente!')
      expect(json['info']['type']).to eq('success')
    end
  end

  context 'when fields are not fine' do
    before do
      post url, params: bad_params, headers: auth_header_user1
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns valid json with the data' do
      json = JSON.parse(response.body)
      expect(json['success']).to eq(false)
      expect(json['info']['message']).to eq('Name El nombre debe tener entre 3 y 30 caracteres')
      expect(json['info']['type']).to eq('error')
    end
  end
end