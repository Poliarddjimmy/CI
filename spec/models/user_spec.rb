# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  DatabaseCleaner.strategy = :truncation
  before(:all) do
    @user = create(:user)
  end

  it 'has a valid factory' do
    user = build(:user, email: 'ksd@kaasd.tes')
    expect(user).to be_valid
  end

  it 'is invalid without an email' do
    @user.email = nil
    expect(@user).to_not be_valid
  end

  it 'is invalid with an invalid email' do
    @user.email = 'sadasdgmail.com'
    expect(@user).to_not be_valid
  end

  it 'is invalid without a password' do
    @user.password = nil
    expect(@user).to_not be_valid
  end

  it 'is invalid with a duplicate email address' do
    @user.email = 'pd@gmail.com'
    expect(@user).to_not be_valid
  end

  it 'is invalid with a password less than 6 characters' do
    @user.password = '12345'
    expect(@user).to_not be_valid
  end

  describe 'Associations' do
    it 'has many contact_files' do
      expect(@user).to respond_to(:contacts)
      expect(@user).to respond_to(:contact_files)
    end
  end
end
