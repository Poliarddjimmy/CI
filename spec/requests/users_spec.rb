# frozen_string_literal: true

require 'rails_helper'

# This test is for the UsersController
RSpec.describe '/users', type: :request do
  DatabaseCleaner.strategy = :truncation

  let(:valid_attributes) {
    {
      email: 'poliarddjimmy@gmail.com',
      password: 'password',
      password_confirmation: 'password',
      name: 'Djimmy Poliard'
    }
  }

  let(:invalid_attributes) {
    {
      email: 'poliarddjimmy@gmail.com',
      password: 'hasjdhas',
      password_confirmation: 'hcjaguwe',
      name: 'Djimmy Poliard'
    }
  }

  before(:all) do
    @user = create(:user)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get users_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get user_url(@user)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_user_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      get edit_user_url(@user)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect {
          post users_url, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the root_path' do
        post users_url, params: { user: valid_attributes }
        expect(response).to redirect_to(root_path) 
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect {
          post users_url, params: { user: invalid_attributes }
        }.to change(User, :count).by(0)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) {
        {
          email: 'pp@gmail.com',
          password: 'password',
          password_confirmation: 'password',
          name: 'Djimmy Poliard'
        }
      }

      it 'updates the requested user' do
        patch user_url(@user), params: { user: new_attributes }
        @user.reload
      end

      it 'redirects to the user' do
        patch user_url(@user), params: { user: new_attributes }
        @user.reload
        expect(response).to redirect_to(user_url(@user))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested user' do
      expect {
        delete user_url(@user)
      }.to change(User, :count).by(-1)
    end

    it 'redirects to the users list' do
      delete user_url(@user)
      expect(response).to redirect_to(users_url)
    end
  end
end
