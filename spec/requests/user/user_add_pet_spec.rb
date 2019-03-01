require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Add Pet request', type: :request do
  let(:user1) { Fabricate(:user) }
  let(:admin_user) { Fabricate(:user, admin: true) }
  let(:url) { '/pets' }
  let(:headers) {{ 'Accept' => 'application/json' }}
  let(:auth_header_user1) {Devise::JWT::TestHelpers.auth_headers(headers, user1)}
  let(:auth_header_admin) {Devise::JWT::TestHelpers.auth_headers(headers, admin_user)}
  let(:params) do
    {
      pet: {
        species: 'Perro',
        breed: 'Beagle',
        name: 'Schobby',
        food: 'Concentrado',
        diseases: 'twertwertw',
        care: 'wrtwertwertwert'
      }
    }
  end
  let(:bad_params) do
    {
        "pet": {
            "species": "",
            "breed": "Beagle",
            "name": "Schooby Doo",
            "food": "Concentrado",
            "diseases": "",
            "care": ""
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
      expect(json['info']['message']).to eq('Mascota registrada exitosamente!')
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
      expect(json['info']['message']).to eq('Species La especie es obligatoria')
      expect(json['info']['type']).to eq('error')
    end
  end
end