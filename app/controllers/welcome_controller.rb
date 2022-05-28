class WelcomeController < ApplicationController
  before_action :rooted

  def home
    @contacts = current_user.contacts.where(failed_reason: nil).page(params[:page]).per(5)
    @contact_files = current_user.contact_files.page(params[:page]).per(5)
  end
end
