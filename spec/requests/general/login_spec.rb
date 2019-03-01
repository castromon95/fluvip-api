require 'rails_helper'

RSpec.describe 'POST Login request', type: :request do
  let(:user) { Fabricate(:user) }
  let(:url) { '/log-in' }
  let(:params) do
    {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end

  context 'when params are correct' do
    before do
      post url, params: params
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns JTW token in authorization header' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns valid json with the JWT token' do
      json = JSON.parse(response.body)
      expect(json['success']).to eq(true)
      expect(json['auth']['logged']).to eq(true)
      expect(json['auth']['jwt_token']).to be_present
    end
  end

  context 'when login params are incorrect' do
    before do
      post url, params: {user: {email: params[:user][:email], password: '92705239845223654'}}
    end

    it 'returns unathorized status' do
      expect(response.status).to eq 401
    end

    it 'returns valid json with response message' do
      json = JSON.parse(response.body)
      expect(json['success']).to eq(false)
      expect(json['info']['message']).to eq('Invalid Email or password.')
      expect(json['info']['type']).to eq('error')
    end
  end


end