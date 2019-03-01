require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Amend Pet request', type: :request do
  let(:user1) { Fabricate(:user) }
  let(:user2) { Fabricate(:user) }
  let(:admin_user) { Fabricate(:user, admin: true) }
  let(:url) { '/pets/amend/' }
  let(:headers) {{ 'Accept' => 'application/json' }}
  let(:auth_header_user1) {Devise::JWT::TestHelpers.auth_headers(headers, user1)}
  let(:auth_header_user2) {Devise::JWT::TestHelpers.auth_headers(headers, user2)}
  let(:auth_header_admin) {Devise::JWT::TestHelpers.auth_headers(headers, admin_user)}
  let(:pet) {Fabricate(:pet, user: user1)}
  let(:params) do
    {
        pet: {
            species: 'Perro',
            breed: 'Beagle',
            name: 'Schobby',
            food: 'Concentrado',
            diseases: '',
            care: ''
        }
    }
  end
  let(:bad_params) do
    {
        "pet": {
            "species": "gsdgsdgf",
            "breed": "Beagle",
            "name": "Schooby Doo",
            "food": "we",
            "diseases": "",
            "care": ""
        }
    }
  end

  context 'when jwt_token is invalid' do
    before do
      post (url + pet.id.to_s), params: params, headers: headers
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

  context 'when a no admin user tries to access the service to edit another persons pet' do
    before do
      post (url + pet.id.to_s), params: params, headers: auth_header_user2
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
      post (url + pet.id.to_s), params: params, headers: auth_header_admin
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns valid json with the data' do
      json = JSON.parse(response.body)
      expect(json['success']).to eq(true)
      expect(json['info']['message']).to eq('Mascota editada exitosamente!')
      expect(json['info']['type']).to eq('success')
    end
  end

  context 'when fields are not fine' do
    before do
      post (url + pet.id.to_s), params: bad_params, headers: auth_header_admin
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns valid json with the data' do
      json = JSON.parse(response.body)
      expect(json['success']).to eq(false)
      expect(json['info']['message']).to eq('Food El tipo de comida debe tener entre 3 y 30 caracteres')
      expect(json['info']['type']).to eq('error')
    end
  end

  context 'when a no admin user tries to access the service to edit his own pet pet' do
    before do
      post (url + pet.id.to_s), params: params, headers: auth_header_user1
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
end