require 'rails_helper'
RSpec.describe 'POST Signup request', type: :request do
  let(:url) { '/sign-up' }
  let(:params) do
    {
      user: {
        email: 'user@example.com',
        password: 'password'
      }
    }
  end

  context 'when user is unauthenticated' do
    before { post url, params: params }

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'returns a valid json with information.' do
      json = JSON.parse(response.body)
      expect(json['success']).to eq(true)
      expect(json['info']['message']).to eq('A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.')
      expect(json['info']['type']).to eq('success')
    end
  end

  context 'when user already exists' do
    before do
      Fabricate :user, email: params[:user][:email]
      post url, params: params
    end

    it 'returns status 200' do
      expect(response.status).to eq 200
    end

    it 'returns a valid json with the message error' do
      json = JSON.parse(response.body)
      expect(json['success']).to eq(false)
      expect(json['info']['message']).to eq('Email has already been taken')
      expect(json['info']['type']).to eq('error')
    end
  end

  context 'when user tries to sign_up once again before email confirmation' do
    before do
      Fabricate :user, confirmed_at: nil
      post url, params: params
    end

    it 'returns status 200' do
      expect(response.status).to eq 200
    end

    it 'returns a valid json with the message error' do
      json = JSON.parse(response.body)
      expect(json['success']).to eq(true)
      expect(json['info']['message']).to eq('A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.')
      expect(json['info']['type']).to eq('success')
    end
  end
end