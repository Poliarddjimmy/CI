require 'rails_helper'

RSpec.describe ContactFile, type: :model do
  before(:all) do
    @contact_file = create(:contact_file)
  end

  it 'has a valid factory' do
    expect(build(:contact_file)).to be_valid
  end

  it 'is invalid without a user' do
    @contact_file.user = nil
    expect(@contact_file).to_not be_valid
  end

  it 'is invalid without a status' do
    @contact_file.status = nil
    expect(@contact_file).to_not be_valid
  end

  it 'is invalid without a file_url' do
    @contact_file.file_url = nil
    expect(@contact_file).to_not be_valid
  end

  # ensure ContactFile model has a 1:m relationship with the User model
  describe 'Associations' do
    it 'has many contact_files' do
      expect(@contact_file).to respond_to(:user)
    end
  end
end
