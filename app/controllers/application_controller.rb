# frozen_string_literal: true

# this class is the application controller
class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  helper_method :loging?, :current_user, :session?
  before_action :rooted, except: [:home]

  def loging?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def rooted
    redirect_to login_path unless loging?
  end

  def session?
    redirect_to root_path if current_user.present?
  end
end
