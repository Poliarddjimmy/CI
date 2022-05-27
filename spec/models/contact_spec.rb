# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact, type: :model do
  before(:all) do
    @contact = create(:contact, email: 'sdawwdwsda@eefef.com')
  end

  it 'has a valid factory' do
    expect(build(:contact, email: 'asidjois@ksjdoaisjdaois.com')).to be_valid
  end

  it 'is invalid without a name' do
    @contact.name = nil
    expect(@contact).to_not be_valid
  end

  it 'is invalid without a phone number' do
    @contact.phone = nil
    expect(@contact).to_not be_valid
  end

  it 'is invalid without a user' do
    @contact.user = nil
    expect(@contact).to_not be_valid
  end

  it 'is invalid without an address' do
    @contact.address = nil
    expect(@contact).to_not be_valid
  end

  it 'is invalid without a credit card' do
    @contact.credit_card = nil
    expect(@contact).to_not be_valid
  end

  it 'is invalid without a franchise' do
    @contact.franchise = nil
    expect(@contact).to_not be_valid
  end

  it 'is invalid with an invalid phone number' do
    @contact.phone = '12345'
    expect(@contact).to_not be_valid
  end

  it 'is not valid with an invalid email' do
    @contact.email = 'sadasdgmail.com'
    expect(@contact).to_not be_valid
  end

  it 'is invalid with an invalid birthdate' do
    @contact.dob = 'sadasd'
    expect(@contact).to_not be_valid
  end

  it 'is invalid with an invalid credit card' do
    @contact.credit_card = '12345'
    expect(@contact).to_not be_valid
  end

  # ensure Contact model has a 1:m relationship with the User model
  describe 'Associations' do
    it 'has many contact_files' do
      expect(@contact).to respond_to(:user)
    end
  end
end
