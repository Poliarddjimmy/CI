require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/contact_files", type: :request do

  before(:each) do
    @user = create(:user)
    post '/logged_in', params: { email: @user.email, password: @user.password }
    @contact_file = create(:contact_file, user: @user)
  end

  describe "GET /index" do
    it "renders a successful response" do
      get contact_files_url
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_contact_file_url
      expect(response).to be_successful
    end
  end

  # delete /contact_files/1
  describe "DELETE /destroy" do
    it "destroys the requested contact_file" do
      expect do
        delete contact_file_url(@contact_file)
      end.to change(ContactFile, :count).by(-1)
    end

    it "redirects to the contact_files list" do
      delete contact_file_url(@contact_file)
      expect(response).to redirect_to(contact_files_url)
    end
  end
end
